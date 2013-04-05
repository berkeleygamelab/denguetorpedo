class ReportsController < ApplicationController

  before_filter :require_login, :except => [:sms, :verification]

  def index 
    @current_report = params[:report]    
    @current_user != nil ? @highlightReportItem = "nav_highlight" : @highlightReportItem = ""
    params[:view] = 'recent' if params[:view].nil? || params[:view] == "undefined"
    params[:view] == 'recent' ? @reports_feed_button_active = "active" : @reports_feed_button_active = ""
    params[:view] == 'open' ? @reports_open_button_active = "active" : @reports_open_button_active = ""
    params[:view] == 'claim' ?  @reports_claimed_button_active = "active" : @reports_claimed_button_active = ""
    params[:view] == 'eliminate' ? @reports_resolved_button_active = "active" : @reports_resolved_button_active = ""
     
    @maps_json = {"map_options" => {"center_latitude" => @current_user.house.location.latitude, 
      "center_longitude" => @current_user.house.location.longitude,
      "detect_location" => false,
      "center_on_user" => false,
      "auto_adjust" => false,
      "auto_zoom" => true,
      "zoom" => 10 }
      }
  
    if (params[:sw_y] && params[:sw_x] && params[:ne_y] && params[:ne_x])
        bounds = [ params[:sw_x].to_f, params[:sw_y].to_f, params[:ne_x].to_f, params[:ne_y].to_f]
        @reports_within_bounds = Report.within_bounds(bounds)
    else    
        @reports_within_bounds = Report.order("created_at DESC")
    end
       
    reports_within_bounds_with_status_filered = []
        
    @reports_within_bounds.each do |report|
      
      if params[:view] == 'recent'
        reports_within_bounds_with_status_filered.append(report)
      elsif params[:view] == 'open' && report.status == :reported
        reports_within_bounds_with_status_filered.append(report)
      elsif params[:view] == 'claim' && report.status == :claimed
        puts "what about here"
        reports_within_bounds_with_status_filered.append(report)
      elsif params[:view] == 'eliminate' && report.status == :eliminated
        reports_within_bounds_with_status_filered.append(report)
      end
    end
    
    @reports_within_bounds = reports_within_bounds_with_status_filered
    locations_within_bounds = @reports_within_bounds.collect {|report| report.location} 
        
    # Probably need to be refactored, for now it works without breaking previous implementation
    @reports = @reports_within_bounds
    @open_feed = @reports
    @claim_feed = @reports
    @eliminate_feed = @reports
  
    newListHtml = ""
    
    if params[:generateReports] == 'True' and not params[:locations].nil?
        locations = params[:locations].split(":")    
        puts locations   
        newReports = []
        puts 'BEFORE'
        puts @reports
    
        if params[:view] == 'open'
          @reports = @open_feed
        elsif params[:view] == 'claim'
          @reports = @claim_feed
        elsif params[:view] == 'eliminate'
          @reports = @eliminate_feed
        end
          
        for report in @reports
          if locations.include? report.location.id.to_s
            newReports.push(report)        
          end    
        end
    
      @reports = newReports
      
      newListHtml = render_to_string(:partial => 'reports/recent.html.haml', :layout => false, :locals => {})
    end
    

    respond_to do |format|  
      format.html {}
      
      format.json {
        if params[:generateReports] == 'True'
          render :json => newListHtml
        else 
          map_markers = locations_within_bounds.to_gmaps4rails {|location, marker| marker.json({ :id => location.id})}    
          data = map_markers
          render :json => data
        end 
      }            
    end    
  end
  
  
  
  
  
  def new
    @report = Report.new
  end

  def create    

    if request.post?
      if params[:report].nil? || params[:report] == ''
        flash[:notice] = 'You must enter a report description.'
        redirect_to :action=>'index', view: 'open'
        return
      elsif params[:location].nil? || params[:location] == ''
        flash[:notice] = 'You must enter an address.'
        redirect_to :action=>'index', view: 'open'
        return
      end
    
      location = Location.find_or_create(params[:location])
      
      begin
        @report = Report.create_from_user(params[:report][:report], :status => :reported, :reporter => @current_user, :location => location)
        @report.before_photo = params[:report][:before_photo]
      rescue
        flash[:notice] = 'Address is invalid or does not exist.'
        redirect_to :action=>'index', view: 'open'
        return
      end
    
      
      if @report.save
        if @current_user != nil
          @current_user.update_attribute(:points, @current_user.points + 100)
        end
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
    if request.put?
      @report = Report.find(params[:report_id])
      
      
      if params[:claim] != nil
        if @report.status == :reported
          if @report.before_photo.exists?
            @report.update_attribute(:status_cd, 1)
            @report.update_attribute(:claimer_id, @current_user.id)
            @report.touch(:claimed_at)
          
            if @current_user != nil
              @current_user.update_attribute(:points, @current_user.points + 50)
            end
          
            flash[:notice] = 'You successfully claimed this report!'
            redirect_to(:back)
          else
            flash[:notice] = 'You cannot claim this report without uploading a photo.'
            redirect_to(:back)
          end
        else
          flash[:notice] = 'You cannot claim this report.'
          redirect_to(:back)
        end              
      elsif params[:eliminate][:after_photo] != nil
        begin
          @report.after_photo = params[:eliminate][:after_photo]
          @report.update_attribute(:status_cd, 2)
          @report.update_attribute(:eliminator_id, @current_user.id)
          @report.touch(:eliminated_at)
        rescue
          flash[:notice] = 'An error has occurred!'
          redirect_to(:back)
          return
        end
      
        if @report.save
          if @current_user != nil
            @current_user.update_attribute(:points, @current_user.points + 250)
          end
          flash[:notice] = 'You eliminated this report!'
          redirect_to(:back)
        else
          #for some reason save causes error here, but in view it looks OK
          flash[:notice] = 'An error has occurred'
          redirect_to(:back)
        end
      
      elsif params[:eliminate][:before_photo] != nil
        @report.before_photo = params[:eliminate][:before_photo]
        if @report.save
          flash[:notice] = "You updated before photo"
          redirect_to(:back)
        else
          flash[:notice] = "An error has occured"
          redirect_to(:back)
        end
      else
        redirect_to(:back)
      end 
    end
  end
  
  def destroy
    @current_user.created_reports.find(params[:id]).destroy
    redirect_to(:back)
  end
end
