class PrizeCodesController < ApplicationController
  # GET /user/:id/prize_codes
  def index
    @prize_codes = PrizeCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prize_codes }
    end
  end

  # GET /user/:id/prize_codes/:prize_id
  def show
    @prize_code = PrizeCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prize_code }
    end
  end

  # GET /prize_codes/new
  # GET /prize_codes/new.json
  def new
    @prize_code = PrizeCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prize_code }
    end
  end

  # POST /prize_codes
  # POST /prize_codes.json
  def create
    @prize_code = PrizeCode.new(params[:prize_code])

    respond_to do |format|
      if @prize_code.save
        format.html { redirect_to @prize_code, notice: 'Prize code was successfully created.' }
        format.json { render json: @prize_code, status: :created, location: @prize_code }
      else
        format.html { render action: "new" }
        format.json { render json: @prize_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prize_codes/1
  # DELETE /prize_codes/1.json
  def destroy
    @prize_code = PrizeCode.find(params[:id])
    @prize_code.destroy

    respond_to do |format|
      format.html { redirect_to prize_codes_url }
      format.json { head :no_content }
    end
  end


end
