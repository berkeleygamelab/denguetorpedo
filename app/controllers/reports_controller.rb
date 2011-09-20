class ReportsController < ApplicationController
  def index
    @reports = current_user.reports
  end
  
  def new
    @report = current_user.reports.new
  end
  
  def create
    @report = current_user.reports.build(params[:report])
    if @report.save
      flash[:notice] = "Report successfully created"
      redirect_to reports_url
    else
      render :action => :new
    end
  end
  
  def edit
    @report = current_user.reports.find(params[:id])
  end
  
  def update
    @report = current_user.reports.find(params[:id])
    if @report.update_attributes(params[:report])
      flash[:notice] = "Successfully updated profile"
      redirect_to reports_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    current_user.reports.find(params[:id]).destroy
    redirect_to reports_url
  end
  
end