class PrizeCodesController < ApplicationController
  # GET /prize_codes
  # GET /prize_codes.json
  def index
    @prize_codes = PrizeCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prize_codes }
    end
  end

  # GET /prize_codes/1
  # GET /prize_codes/1.json
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

  # GET /prize_codes/1/edit
  def edit
    @prize_code = PrizeCode.find(params[:id])
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

  # PUT /prize_codes/1
  # PUT /prize_codes/1.json
  def update
    @prize_code = PrizeCode.find(params[:id])

    respond_to do |format|
      if @prize_code.update_attributes(params[:prize_code])
        format.html { redirect_to @prize_code, notice: 'Prize code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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
