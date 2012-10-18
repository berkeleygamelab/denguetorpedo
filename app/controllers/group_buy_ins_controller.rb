class GroupBuyInsController < ApplicationController
  # GET /group_buy_ins
  # GET /group_buy_ins.json
  def index
    @group_buy_ins = GroupBuyIn.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_buy_ins }
    end
  end

  # GET /group_buy_ins/1
  # GET /group_buy_ins/1.json
  def show
    @group_buy_in = GroupBuyIn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_buy_in }
    end
  end

  # GET /group_buy_ins/new
  # GET /group_buy_ins/new.json
  def new
    @group_buy_in = GroupBuyIn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_buy_in }
    end
  end

  # GET /group_buy_ins/1/edit
  def edit
    @group_buy_in = GroupBuyIn.find(params[:id])
  end

  # POST /group_buy_ins
  # POST /group_buy_ins.json
  def create
    @group_buy_in = GroupBuyIn.new(params[:group_buy_in])

    respond_to do |format|
      if @group_buy_in.save
        format.html { redirect_to @group_buy_in, notice: 'Group buy in was successfully created.' }
        format.json { render json: @group_buy_in, status: :created, location: @group_buy_in }
      else
        format.html { render action: "new" }
        format.json { render json: @group_buy_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_buy_ins/1
  # PUT /group_buy_ins/1.json
  def update
    @group_buy_in = GroupBuyIn.find(params[:id])

    respond_to do |format|
      if @group_buy_in.update_attributes(params[:group_buy_in])
        format.html { redirect_to @group_buy_in, notice: 'Group buy in was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_buy_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_buy_ins/1
  # DELETE /group_buy_ins/1.json
  def destroy
    @group_buy_in = GroupBuyIn.find(params[:id])
    @group_buy_in.destroy

    respond_to do |format|
      format.html { redirect_to group_buy_ins_url }
      format.json { head :no_content }
    end
  end
end
