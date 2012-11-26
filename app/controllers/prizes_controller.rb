# encoding: UTF-8

class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.json
  def index

    @user = current_user

    @prizes = Prize.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prizes }
    end
  end

  # GET /prizes/1
  # GET /prizes/1.json
  def show
    @prize = Prize.find(params[:id])

    if @current_user.nil?
      enoughPoints = false
    else 
      @enoughPoints = @current_user.points >= @prize.cost ? true : false
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prize }
    end
  end

  # GET /prizes/new
  # GET /prizes/new.json
  def new
    @prize = Prize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prize }
    end
  end

  # POST /prizes/1
  def new_prize_code
    begin
      unless @current_user.nil?
        @prize = Prize.find(params[:id])

        respond_to do |format|
          if @current_user.points >= @prize.cost
            if !@current_user.phone_number.nil?
              @prize.generate_prize_code(@current_user.id)
              format.html { redirect_to(@prize, :notice => "Premio resgatado! Vôce tem #{@current_user.points - @prize.cost} pontos".encode("UTF-8")) }
            else
              format.html { redirect_to(@prize, :alert => 'Need a valid phone number to redeem prize.') }
            end
          else
            format.html { redirect_to(@prize, :alert => "Vôce precisa de mais pontos. Vôce tem #{@current_user.points} pontos") }
          end
        end
      end
    rescue
      respond_to do |format|
        format.html { redirect_to(@prize, :alert => "Something went wrong. Please try again later.") }
      end
    end
  end

  # GET /prizes/1/edit
  def edit
    @prize = Prize.find(params[:id])
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @prize = Prize.new(params[:prize])

    respond_to do |format|
      if @prize.save
        format.html { redirect_to @prize, notice: 'Prize was successfully created.' }
        format.json { render json: @prize, status: :created, location: @prize }
      else
        format.html { render action: "new" }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /prizes/1
  # PUT /prizes/1.json
  def update
    @prize = Prize.find(params[:id])

    respond_to do |format|
      if @prize.update_attributes(params[:prize])
        format.html { redirect_to @prize, notice: 'Prize was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @prize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.json
  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy

    respond_to do |format|
      format.html { redirect_to prizes_url }
      format.json { head :no_content }
    end
  end
end
