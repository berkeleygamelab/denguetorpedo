class BuyInsController < ApplicationController
  # GET /buy_ins
  # GET /buy_ins.json
  def index
    @buy_ins = BuyIn.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buy_ins }
    end
  end

  # GET /buy_ins/1
  # GET /buy_ins/1.json
  def show
    @buy_in = BuyIn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @buy_in }
    end
  end

  # GET /buy_ins/new
  # GET /buy_ins/new.json
  def new
    @buy_in = BuyIn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @buy_in }
    end
  end

  # GET /buy_ins/1/edit
  def edit
    @buy_in = BuyIn.find(params[:id])
  end

  # POST /buy_ins
  # POST /buy_ins.json
  def create
    @buy_in = BuyIn.new(params[:buy_in])

    respond_to do |format|
      if @buy_in.save
        format.html { redirect_to @buy_in, notice: 'Buy in was successfully created.' }
        format.json { render json: @buy_in, status: :created, location: @buy_in }
      else
        format.html { render action: "new" }
        format.json { render json: @buy_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buy_ins/1
  # PUT /buy_ins/1.json
  def update
    @buy_in = BuyIn.find(params[:id])

    respond_to do |format|
      if @buy_in.update_attributes(params[:buy_in])
        format.html { redirect_to @buy_in, notice: 'Buy in was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @buy_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buy_ins/1
  # DELETE /buy_ins/1.json
  def destroy
    @buy_in = BuyIn.find(params[:id])
    @buy_in.destroy

    respond_to do |format|
      format.html { redirect_to buy_ins_url }
      format.json { head :no_content }
    end
  end
end
