class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.json
  def index
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
