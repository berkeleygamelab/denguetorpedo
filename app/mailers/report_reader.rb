require 'base64'

class ReportReader < ActionMailer::Base
  default from: "reportdengue@gmail.com"
  
  def welcome_mail(login, password, email_addrs)
    @login = login
    @password = password
    @url = "http://reportdengue.herokuapp.com/login"
    mail(:to => email_addrs)
  end

  def report_added_notification(email_addrs)
    mail(:to => email_addrs)
  end

  def report_failed_notification(email_addrs)
    mail(:to => email_addrs)
  end

  def incomplete_information(email_addrs)
    mail(:to => email_addrs)
  end

  def user_failed_to_create(email_addrs)
    mail(:to => email_addrs)
  end
    
  def receive(email)
    logger = Logger.new(STDOUT)
    logger.info "begin to parse the incoming email..."

    email_addrs = email.from_addrs[0]
    logger.debug "the email address is: " + email_addrs 
    login = email.from_addrs[0].split('@')[0]
    logger.debug "the login/phone number is: " + login
    
    user = User.find_by_username(login) 
    if !user
      user = create_and_save_user!(login, email_addrs)
    end
    
    parser = MailParser::Parser.new(email)
        
    if parser.report && parser.nation && parser.city && parser.address && parser.state
      logger.debug "parsed data = nation: " + parser.nation + " address: " + parser.address + " neighborhood: " + parser.neighborhood + " city: " + parser.city + " state: " + parser.state + " report: " + parser.report
      report = Report.new(:user_id => user.id, :nation => nation, :address => address, :neighborhood => neighborhood, :city => city, :state => state, :report => report)

      if report.save 
        logger.info "new report sucessfully added"
        ReportReader.report_added_notification(email_addrs).deliver
      else
        logger.info "new report failed to add"
        ReportReader.report_failed_notification(email_addrs).deliver
      end
    else
      logger.info "no match was found or some fields were not specified"
      ReportReader.incomplete_information(email_addrs).deliver
    end
  end 
    
  private
    
  def create_and_save_user!(login, email_addrs)
    logger = Logger.new(STDOUT)
    password = ApplicationHelper.temp_password_generator
    new_user = User.new(:username => login, :password => password, :password_confirmation => password)
    if new_user.save
      logger.info "new user created and send welcome report"
      ReportReader.welcome_mail(login, password, email_addrs).deliver
    else
      logger.info "unable to save new user"
      ReportReader.user_failed_to_create(email_addrs).deliver
    end
    new_user
  end 
    
end