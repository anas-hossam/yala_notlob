class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @order=Order.find(params[:order_id])


    @items = @order.items.all
    @item = @order.items.new
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @order=Order.find(params[:order_id])
    @item = @order.items.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @order=Order.find(params[:order_id])
    @item =@order.items.new(item_params)
    @item.order_id=@order.id
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.save
        ##################################### Update Join ################################################
        @order.joined += 1
        @order.save
        ########################
        @order_detail = @order.order_details.where(user_id: @item.user_id)
        puts "kkk"<<@order_detail.inspect
        if @order_detail.empty?
          format.html { redirect_to order_path(@order), notice: 'You should be one of Invited Friends' }
        else
          @order_detail[0].joined = 1
          @order_detail[0].save
          puts "joined "<<@order_detail.inspect
        end
        ###########################################End[Update Join]#######################################
        format.html { redirect_to order_path(@order), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }

        Pusher.trigger('items-channel', 'last-items', {
            message: @item,
            username: current_user.name,
            ordermeal: @order.meal
        });
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item.order_id=@order.id
    @item.user_id = current_user.id
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to order_path(@order), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to order_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @order=Order.find(params[:order_id])
      @item = @order.items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :user_id, :order_id, :amount, :price, :comment)
    end
end
