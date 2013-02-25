class ReportsController < ApplicationController

  before_filter :require_login, :except => [:sms, :verification]

  def index
        
   
    if (params[:claimed_report] != nil)      
      report = Report.find(params[:claimed_report])
      if report.status_cd == 0
        report.update_attribute(:status_cd, 1)
        report.update_attribute(:claimer_id, @current_user.id)
        flash[:notice] = 'You successfully claimed this report!'
      else
        flash[:notice] = 'You cannot claim this report.'
      end
    end
    @current_report = params[:report]
    @highlightReportItem = ""
    if (@current_user != nil) 
      @highlightReportItem = "nav_highlight"
    end
    
    @reports_feed_button_active = ""
    @reports_open_button_active = ""
    @reports_claimed_button_active = ""
    @reports_resolved_button_active = ""           
   

    @maps_json = {
     "map_options" => {"center_latitude" => @current_user.house.location.latitude, 
                       "center_longitude" => @current_user.house.location.longitude,
                       "detect_location" => false,
                       "center_on_user" => false,
                       "auto_adjust" => false,
                       "auto_zoom" => true,
                       "zoom" => 15 },
                 }
    if params[:view].nil? 
      params[:view] = 'recent'
    end    
    if params[:view] == 'recent'
      @reports_feed_button_active = "active"
    elsif params[:view] == 'open'
      @reports_open_button_active = "active"
      @report = Report.new
    elsif params[:view] == 'claim'
      @reports_claimed_button_active = "active"
    else #params[:view] == 'eliminate'
      @reports_resolved_button_active = "active"
    end
    
    @random_sponsors = []
    9.times do
      @random_sponsors.push('home_images/sponsor'+(rand(5)+1).to_s+'.png')
    end    
    if (params[:sw_y] && params[:sw_x] && params[:ne_y] && params[:ne_x])
        bounds = [ params[:sw_x].to_f, params[:sw_y].to_f, params[:ne_x].to_f, params[:ne_y].to_f ]
        @reports_within_bounds = Report.within_bounds(bounds)
    else
        @reports_within_bounds = Report.all
    end
    
    puts('bound check')
    puts @reports_within_bounds
    locations_within_bounds = []
    for report in @reports_within_bounds
      locations_within_bounds.append(report.location)
    end
    #Query--------------------------------------------------------------------------
    @reports = []
    for report in @reports_within_bounds
        if report.claimer_id == @current_user.id or report.reporter_id == @current_user.id or report.eliminator_id == @current_user.id
          @reports.append(report)
        end
      end 
    @claim_feed = Report.find(:all, :from => 'reports', :conditions => ['reports.status_cd = ?', 0],
    :order => 'updated_at desc')
    @eliminate_feed = Report.find(:all, :from => 'reports', 
    :conditions => ['reports.status_cd = ? and reports.claimer_id = ?', 1, @current_user.id], 
    :order => 'updated_at desc')
    #--------------------------------------------------------------------------------
    newListHtml = ""
    if params[:view].nil? || params[:view] == 'recent'
      if params[:generateReports] == 'True' and not params[:locations].nil?
        
        locations = params[:locations].split(":")    
        puts locations   
        newReports = []
        puts 'BEFORE'
        puts @reports
        for report in @reports
          if locations.include? report.location.id.to_s
            newReports.push(report)        
          end    
        end
      end
      puts newReports
      @reports = newReports
      newListHtml = render_to_string(:partial => 'reports/recent.html.haml', :layout => false, 
                 :locals => {})
    end
    respond_to do |format|
      format.html{
            
      }
      map_markers = locations_within_bounds.to_gmaps4rails do |location, marker|
        marker.json({ :id => location.id})      
      end           
      format.json {
        if params[:generateReports] == 'True'
          render :json => newListHtml
        else    
          data = map_markers
          render :json => data
        end 
        } 
        #"html" => }}      
      puts map_markers      
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
  def eliminate
    
  end
  def update
    if request.put?
      @report = Report.find(params[:report_id])
      if params[:eliminate][:after_photo] != nil
        begin
          @report.after_photo = params[:eliminate][:after_photo]
          @report.update_attribute(:status_cd, 2)
          @report.update_attribute(:eliminator_id, @current_user.id)
        rescue
          flash[:notice] = 'An error has occurred!'
          redirect_to :action=>'index', view: 'eliminate'
          return
        end
      
        
        if @report.save
          flash[:notice] = 'You eliminated this report!'
          redirect_to :action=>'index', view: 'recent'
        else
          #for some reason save causes error here, but in view it looks OK
          flash[:notice] = 'An error has occurred'
          redirect_to :action=>"index", view: 'eliminate'
        end
      else
        redirect_to :action=>"index", view: 'eliminate'
      end
          
    end
  end
  
  def destroy
    @current_user.created_reports.find(params[:id]).destroy
    redirect_to user_reports_url
  end
end
