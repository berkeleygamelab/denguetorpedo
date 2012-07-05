class ReportsController < ApplicationController

  before_filter :require_login, :except => [:sms, :verification]

  def index
    #@json = User.all.to_gmaps4rails
    @reports = @current_user.reports
  end

  def new
    
  end
  
  def create    



        #report content
    #reporter id
    #claimer id
    #location id
    #before file name
    #before file size
    #before file content
    #before file updated_at
    
    if request.post?
      if params[:report].nil? || params[:report] == ''
        flash[:notice] = 'You must enter a report description.'
        redirect_to :action=>'index', view: 'open'
        return
      elsif params[:loc].nil? || params[:loc] == ''
        flash[:notice] = 'You must enter an address.'
        redirect_to :action=>'index', view: 'open'
        return
      end
      location = params[:loc]
      loc = Location.find_or_create(location)
      begin
      @report = Report.create_from_user(params[:report], 
            :status=>:reported, :reporter=>@current_user, :location=>loc )
      rescue
        flash[:notice] = 'Address is invalid or does not exist.'
        redirect_to :action=>'index', view: 'open'
        return
      end
      if params[:before_photo].nil? || params[:before_photo] == ''
          puts 'DIDNT SAVE FILE'
      else
          puts 'SAVING FILE'
          @report.update_attributes(:before_photo => params[:before_photo])
      end
      if @report.save
        flash[:notice] = 'Report posted succesfully.'
        redirect_to :action=>'index', view: 'recent'
      else
        flash[:notice] = 'Report failed to post.'
        redirect_to :action=>"index", view: 'open'
      end
    end
  end
  
  def edit
    @report = @current_user.created_reports.find(params[:id])
  end
    
  def verification
    @unverified_reports = Report.unverified_reports
  end
  
  def sms
    logger = Logger.new(STDOUT)  
    logger.info params[:Body].inspect
    logger.info params[:From].inspect
    
    @account_sid = 'AC696e86d23ebba91cbf65f1383cf63e7d'
    @auth_token = 'a49ee186176ead11c760fd77aeaeb26c'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    
    login = params[:From].delete('+')
    user = User.find_by_username(login)    
  
    if !user
      password = ApplicationHelper.temp_password_generator
      logger.info password
      user = User.new(:username => login, :password => password, :password_confirmation => password)
      logger.info user.inspect
      
      if user.save
        logger.info "new user created and send welcome report"
        response = 'username: ' + params[:From].delete('+') + ' Temporary password: ' + password + ' To login to the site, go to http://reportdengue.herokuapp.com/login' 
        @account.sms.messages.create(:from => '+15109854798', :to => params[:From], :body  => response)
      end
    end
    
    logger.info "parsing the sms text..."
    parser = MailParser::Parser.new(params[:Body], 'sms')
    
    if parser.report && parser.nation && parser.city && parser.address && parser.state
      
      if parser.neighborhood.nil?
        neighborhood = ""
      else
        neighborhood = parser.neighborhood
      end
      
      logger.debug "Parsed data = nation: " + parser.nation + " address: " + parser.address + " neighborhood: " + neighborhood + " city: " + parser.city + " state: " + parser.state + " report: " + parser.report
      report = Report.new(:user_id => user.id, :nation => parser.nation, :address => parser.address, :neighborhood => neighborhood, :city => parser.city, :state => parser.state, :report => parser.report)
      
      if report.save 
        logger.info("New report sucessfully added")
        @account.sms.messages.create(:from => '+15109854798', :to => params[:From], :body  => 'Congratulation! your report has been processed and added to our database')
      else
        logger.info("New report failed to add")
        @account.sms.messages.create(:from => '+15109854798', :to => params[:From], :body  => 'I am sorry, but something went wrong in our system. We were unable to add your report')
      end
    else
      logger.info "No match was found or some fields were not specified"
      @account.sms.messages.create(:from => '+15109854798', :to => params[:From], :body  => 'We could not understand your report because some hashtags were missing...')
    end
  end
  
  def update
    @report = @current_user.created_reports.find(params[:id])
    if @report.update_attributes(params[:report])
      redirect_to user_reports_url, notice: "Successfully updated report"
    else
      render "edit"
    end
  end
  
  def destroy
    @current_user.created_reports.find(params[:id]).destroy
    redirect_to user_reports_url
  end
end
