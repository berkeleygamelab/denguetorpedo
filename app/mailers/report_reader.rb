class ReportReader < ActionMailer::Base
  default from: "reportdengue@gmail.com"
  
  def welcome_new_user_notification(login, password, email_addrs)
    @login = login
    @password = password
    @url = "http://reportdengue.herokuapp.com/"
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
    
  def receive(email)
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production'# flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    logger.info "begin to parse the incoming email..."

    logger.info "process email via MMS2R"
    parsed_email = MMS2R::Media.new(email)
    text_body = parsed_email.body
    
    email_addrs = email.from_addrs[0]
    logger.info "the email address is: " + email_addrs 
    phone_number = parsed_email.number
    logger.info "the login/phone number is: " + phone_number
    
    logger.info "try to find user by phone number"
    user = User.find_by_phone_number(phone_number) 
    
    if !user
      logger.info "did not find user, create a user account"
      user = create_user!(phone_number, email_addrs)
    end
    
    logger.info "try to parse the text to extract report and address"
    parsed_result = text_body.scan(/^(.+)@(.+)$/)
        
    if parsed_result.count == 0

      # For verifying prize codes
      second_parsed_result = text_body.scan(/verify@(.+)$/)
      if second_parsed_result.count == 0
        logger.info "incorrect report format"
        ReportReader.incomplete_information_notification(email_addrs).deliver
      else
        logger.info "extracted verification code"
        prizecode = second_parsed_result[0][0]

        logger.info "prizecode: #{prizecode}"
        @prize = PrizeCode.find_by_code("?", prizecode)
        @prize.nil? ? @prize.send_no(phone_number) : @prize.first.send_yes(phone_number)
      end

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
      else
        logger.info "new report failed to add"
        ReportReader.report_failed_notification(email_addrs).deliver
      end
    end    
    
    
    # Legacy Code
    #
    #if parser.report && parser.nation && parser.city && parser.address && parser.state
      
    #  if parser.neighborhood.nil?
    #    neighborhood = ""
    #  else
    #    neighborhood = parser.neighborhood
    #  end
      
    #  logger.debug "parsed data = nation: " + parser.nation + " address: " + parser.address + " neighborhood: " + neighborhood + " city: " + parser.city + " state: " + parser.state + " report: " + parser.report
    #  report = Report.new(:user_id => user.id, :nation => parser.nation, :address => parser.address, :neighborhood => neighborhood, :city => parser.city, :state => parser.state, :report => parser.report)

    #  if report.save 
    #    logger.info "new report sucessfully added"
    #    ReportReader.report_added_notification(email_addrs).deliver
    #  else
    #    logger.info "new report failed to add"
    #    ReportReader.report_failed_notification(email_addrs).deliver
    #  end
    #else
    #  logger.info "no match was found or some fields were not specified"
    #  ReportReader.incomplete_information(email_addrs).deliver
    #end
  end 
    
  private
    
  def create_user!(phone_number, email_addrs)
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production'# flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    
    password = ApplicationHelper.temp_password_generator
    new_user = User.new(:username => phone_number.to_s, :password => password, :password_confirmation => password, :phone_number => phone_number)
    
    if new_user.save
      logger.info "new user created and send welcome report"
      ReportReader.welcome_new_user_notification(phone_number, password, email_addrs).deliver
    else
      logger.info "unable to save new user"
      ReportReader.user_failed_to_create_notification(email_addrs).deliver
    end
    new_user
  end 
    
end
