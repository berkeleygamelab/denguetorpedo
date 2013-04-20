#!/bin/env ruby
# encoding: utf-8

class SmsGatewayController < ApplicationController 
  
  def inject    
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production' # flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    logger.info "begin to parse the incoming sms..."
        
    # Assume user always registers from the web app for the alpha test
    logger.info "Report Submission"

    board = params[:board]
    text = params[:text]
    phone_number = params[:origin]
    logger.info "board = " + board
    logger.info "phone_number = " + phone_number
    logger.info "text = " + text
  
    logger.info "identifying the user"
    user = User.find_by_phone_number(phone_number.to_s.strip)
    logger.info "user info = " + user.inspect

    if user
      parsed_result = text.scan(/^(.+)@(.+)$/)
      
      logger.info "parsed result is = " + parsed_result.to_s
      
      if parsed_result.count == 0
        logger.info "incorrect report format"
        ReportReader.incomplete_information_notification(user.email).deliver
        Notification.new(:phone => phone_number.to_s, :text => "Erro na mensagem. O formato correto é: descrição do foco AT localização do foco. Por favor, reenvie sua mensagem.", :board => board.to_s).save      
      else
        logger.info "successfully extracted report and address"
        report = parsed_result[0][0]
        address = parsed_result[0][1]

        logger.info "report: #{report}, address: #{address}"
        logger.info "try to see if an address already exist, if not create it"
        location = Location.find_or_create(address)
        logger.info "location: #{location}"

        report_obj = Report.create_from_user(report, :status => :reported, :reporter => user, :location => location, :before_photo => nil)
        if report_obj.save
          user.update_attribute(:points, user.points + 50) 
          logger.info "new report sucessfully added"
          ReportReader.report_added_notification(user.email).deliver
          Notification.new(:phone => phone_number.to_s, :text => "Parabéns! O seu relato foi recebido e adicionado ao Dengue Torpedo.", :board => board.to_s).save
        else
          logger.info "new report failed to add"
          # Send both user and developer an email notifcation that something broke in the system.
          ReportReader.report_failed_notification(user.email).deliver
          ReportReader.report_failed_notification("jayst088@gmail.com").deliver
          ReportReader.report_failed_notification("jholston@berkeley.edu").deliver
          Notification.new(:phone => phone_number.to_s, :text => "Nós não pudemos adicionar o seu relato porque houve um erro no nosso sistema. Já estamos trabalhando numa solução.", :board => board.to_s).save
        end
      end
    else
      logger.info "this user does not have an account, need to register"
      Notification.new(:phone => phone_number.to_s, :text => "Nós não pudemos adicionar o seu relato ao Dengue Torpedo porque você ainda não tem uma conta. Registre-se no site www.denguetorpedo.com.", :board => board.to_s).save
    end

    render :text => "OK"
  end
  
  def notifications
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production' # flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    logger.info "retreiving notifications..."
    logger.info "board = " + params[:board]
    
    notifications = Notification.where("board = ?", params[:board])
    result = ""
    
    notifications.each do |notification|
      result = result + "#{notification.id}, #{notification.phone}, #{notification.text}\n"
    end
    
    render :text => result
  end
  
  def remove
    STDOUT.sync = true unless ENV['RAILS_ENV'] == 'production' # flush all log messages to STDOUT
    logger = Logger.new(STDOUT)
    logger.info "removing notifications from database..." 
    logger.info "board = " + params[:board]
    logger.info "ids = " + params[:id]
    
    list_of_ids = params[:id].split(",")
    
    logger.info "list of ids = " + list_of_ids.to_s
  
    list_of_ids.each do |id|
      notification = Notification.find(id)
      if notification.board == params[:board]
        logger.info notification.inspect
        notification.delete
      end
    end
    
    render :text => "OK"
  end
end


