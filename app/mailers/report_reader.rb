require 'nexmo'

class ReportReader < ActionMailer::Base
  default from: "reportdengue@gmail.com"

  def welcome_new_user_notification(login, password, email_addrs)
    @login = login
    @password = password
    @url = "http://denguetorpedo.herokuapp.com/"
    mail(:to => email_addrs, :subject => "Welcome to Report Dengue")
  end
  
  def user_failed_to_create_notification(email_addrs)
    mail(:to => email_addrs, :subject => "Report Dengue is unable to create an account for you")
  end

  def report_added_notification(email_addrs)
    mail(:to => email_addrs, :subject => "Report Dengue has successfully added your report")
  end

  def report_failed_notification(email_addrs)
    mail(:to => email_addrs, :subject => "Report Dengue has failed to add your report")
  end

  def incomplete_information_notification(email_addrs)
    mail(:to => email_addrs, :subject => "Your report has incorrect format")
  end
  
  def send_notification(phone_number, message)
    nexmo = Nexmo::Client.new('3ded145b', '4ca9d186')
    response = nexmo.send_message!({:to => phone_number, :from => '15109003058', :text => 'I am sorry, but you have previously registered'})

    if !response.ok?
      logger.info "something went wrong, notification was not delivered"
    end
  end
    
  def receive(email)
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production' # flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    logger.info "begin to parse the incoming email..."

    logger.info "process email via MMS2R"
    parsed_email = MMS2R::Media.new(email)
    
    subject = parsed_email.subject
    
    if subject.include? "Register"
      logger.info "User Registration"
      
      text_body = parsed_email.body
      logger.info "text body is: " + text_body
      
      split_text_body = text_body.split(" ")
      phone_number = split_text_body[0].delete("+")
      email = split_text_body[1]
      logger.info "the login/phone number is: " + phone_number
      logger.info "the email is: " + email
      
      logger.info "try to find user by phone number, still check in case of duplicate registration"
      user = User.find_by_phone_number(phone_number)
      
      if user
        logger.info "this user has already registered. send out notification"
        ReportReader.send_notification(phone_number, "I am sorry, but you have previously registered")
      else
        logger.info "did not find user, create a user account"
        user = create_user!(phone_number, email)
      end
    else
      logger.info "Report Submission"
      
      text_body = parsed_email.body
      logger.info "text body is: " + text_body
      phone_number = subject.delete("+")
      logger.info "the login/phone number is: " + phone_number
      
      logger.info "identifying the user"
      user = User.find_by_phone_number(phone_number)
      
      if user
        parsed_result = text_body.scan(/^(.+)@(.+)$/)
        if parsed_result.count == 0
          logger.info "incorrect report format"
          ReportReader.incomplete_information_notification(email_addrs).delivers
          ReportReader.send_notification(phone_number, "I am sorry, but the format must be: report@address")
        else
          logger.info "successfully extracted report and address"
          report = parsed_result[0][0]
          address = parsed_result[0][1]

          logger.info "report: #{report}, address: #{address}"
          logger.info "try to see if an address already exist, if not create it"
          location = Location.find_or_create(address)
          logger.info "location: #{location}"

          before_photo = parsed_email.default_media
          report_obj = Report.create_from_user(report, :status => :reported, :reporter => user, :location => location, :before_photo => before_photo)

          if report_obj.save 
            logger.info "new report sucessfully added"
            ReportReader.report_added_notification(email_addrs).deliver
            ReportReader.send_notification(phone_number, "Congratulation! your report has been processed and added to our database")
          else
            logger.info "new report failed to add"
            ReportReader.report_failed_notification(email_addrs).deliver
            ReportReader.send_notification(phone_number, "Something went wrong in our system. We were unable to add your report")
          end
        end
    
      else
        logger.info "this user does not have an account, need to register"
        ReportReader.send_notification(phone_number, "I am sorry, but you do not have an account. Please register")
      end  
      
    end

    #if parsed_result.count == 0
    #  For verifying prize codes
    #  second_parsed_result = text_body.scan(/verify@(.+)$/)
    #  if second_parsed_result.count == 0
    #    logger.info "incorrect report format"
    #    ReportReader.incomplete_information_notification(email_addrs).deliver
    #  else
    #    logger.info "extracted verification code"
    #    prizecode = second_parsed_result[0][0]

    #    logger.info "prizecode: #{prizecode}"
    #    @prize = PrizeCode.find_by_code("?", prizecode).first
    #    @prize.nil? ? PrizeCode.send_no(phone_number) : @prize.send_yes(phone_number)
    #  end
  end 
    
  private
    
  def create_user!(phone_number, email)
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production'# flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    
    password = ApplicationHelper.temp_password_generator
    new_user = User.new(:username => phone_number.to_s, :password => password, :password_confirmation => password, :phone_number => phone_number)
    
    if new_user.save
      logger.info "new user created and send welcome report"
      ReportReader.welcome_new_user_notification(phone_number, password, email).deliver
      ReportReader.send_notification(phone_number, "username: " + phone_number + " temporary password: " + password + " To login to the site, go to http://reportdengue.herokuapp.com/")
    else
      logger.info "unable to save new user"
      ReportReader.user_failed_to_create_notification(email).deliver
      ReportReader.send_notification(phone_number, "Something went wrong in our system. We were unable to create an account for you.")
    end
    new_user
  end 
    
end
