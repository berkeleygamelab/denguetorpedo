# encoding: UTF-8

class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.json
  before_filter :require_login, :except => :index
  def index

    @user = current_user

    @prizes = Prize.where(:is_badge => false)
    @available = Prize.where('stock > 0').where(:is_badge => false)
    @redeemed = Prize.where('stock = 0').where(:is_badge => false)
    @medals = Prize.where(:is_badge => true)
    @filter = params[:filter]
    @max = params[:max]
    @sponsors = User.where(:role => 'lojista').sort { |x, y| x.house.name <=> y.house.name}
    if @filter == "pontos"
      if @max == "500"
        @filtered_prizes = Prize.where('cost <= 500').where(:is_badge => false)
      elsif @max == "1000"
        @filtered_prizes = Prize.where('cost > 500 AND cost < 1000').where(:is_badge => false)
      elsif @max == "5000"
        @filtered_prizes = Prize.where('cost > 1000 AND cost <5000').where(:is_badge => false)
      else
        @filtered_prizes = Prize.where('cost >= 5000').where(:is_badge => false)
      end
    elsif @filter == "badges"
      @filtered_prizes = Prize.where(:is_badge => true)
    elsif @filter == "individual"
      @filtered_prizes = Prize.where(:community_prize => false).where(:is_badge => false)
    elsif @filter == "community"
      @filtered_prizes = Prize.where(:community_prize => true).where(:is_badge => false)
    else
      @individual = Prize.where(:community_prize => false, :is_badge => false)
      @community = Prize.where(:community_prize => true, :is_badge => false)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prizes }
    end
  end

  # GET /prizes/1
  # GET /prizes/1.json
  def show
    @prize = Prize.find(params[:id])
    @user = current_user

    if @current_user.nil?
      enoughPoints = false
    else 
      @enoughPoints = @current_user.points >= @prize.cost ? true : false
    end

    respond_to do |format|
      format.html #{ render :partial => 'prizeview', :locals => {:user_id => 1}}
      format.json { render json: @prize }
    end
  end

  # GET /prizes/new
  # GET /prizes/new.json
  def new
    @prize = Prize.new
    # @user = current_user
    # @users = User.where(:role => "lojista").map { |user| user.display_name }
    @users = User.where(:role => "lojista").collect{ |user| [user.house.name, user.id]}
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
              @prize_code = @prize.generate_prize_code(@current_user.id)
              format.html { redirect_to(@prize_code, :notice => "Prêmio resgatado! Vôce tem #{@current_user.points - @prize.cost} pontos".encode("UTF-8")) }
            else
              format.html { redirect_to(@prize_code, :alert => 'Need a valid phone number to redeem prize.') }
            end
          else
            format.html { redirect_to(@prize_code, :alert => "Vôce precisa de mais pontos. Vôce tem #{@current_user.points} pontos") }
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
    @user = @current_user
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @prize = Prize.new(params[:prize])
    @user = current_user
    @users = User.where(:role => "lojista").collect{ |user| [user.house.name, user.id]}
    respond_to do |format|
      if @prize.save
        format.html { redirect_to @prize, notice: 'Prêmio criado com sucesso!' }
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
