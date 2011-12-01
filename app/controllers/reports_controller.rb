class ReportsController < ApplicationController
  def index
    @reports = User.find(params[:user_id]).reports
  end
  
  def new
    unless @current_user.nil?
      @report = @current_user.created_reports.new
      @report.location = Location.new
    else
      render :nothing => true
    end
  end
  
  def create
    unless @current_user.nil?
      loc_hash = params[:location]
      location = Location.new(:nation => loc_hash[:nation],
                              :state => loc_hash[:state],
                              :city => loc_hash[:city],
                              :neighborhood => loc_hash[:neighborhood],
                              :address => loc_hash[:address])
      geocode = Gmaps4rails.geocode(location.complete_address())
      if geocode.size != 1
        return render :nothing => true # TODO: give a helpful message if geocoding failed
      end
      lat = geocode[0][:lat]
      lon = geocode[0][:lng]
      geocode = geocode[0]
      
      existing_loc = Location.where(:latitude => lat, :longitude => lon)
      if existing_loc.size == 0
        unless location.save
          return render :nothing => true
        end
        loc = location
      else
        loc = existing_loc[0]
      end
      
      @report = @current_user.created_reports.build(params[:report])
      @report.location_id = loc.id
      if @report.save
        redirect_to user_reports_url, notice: "Report successfully created"
      else
        render "new"
      end
    else
      render :nothing => true
    end
  end
  
  def edit
    unless @current_user.nil?
      @report = @current_user.created_reports.find(params[:id])
    else
      render :nothing => true
    end
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
    unless @current_user.nil?
      @report = @current_user.created_reports.find(params[:id])
      if @report.update_attributes(params[:report])
        redirect_to user_reports_url, notice: "Successfully updated report"
      else
        render "edit"
      end
    else
      render :nothing => true
    end
  end
  
  def destroy
    unless @current_user.nil?
      @current_user.created_reports.find(params[:id]).destroy
      redirect_to user_reports_url
    else
      render :nothing => true
    end
  end
end
