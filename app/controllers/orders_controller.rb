class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order=Order.find(params[:id])
    @items = @order.items.all
    @item=@order.items.new
    @order_details = @order.order_details.all
    @friends_Invited=[]
    @friends_Joined=[]
    @order_details.each do |i|
      @user=User.find(i.user_id)
      @friends_Invited.push(@user.name)
      if i.joined == true
        @user=User.find(i.user_id)
        @friends_Joined.push(@user.name)
      end
    end
    render template: 'items/index'
  end

  # GET /orders/new
  def new
    @order = Order.new
    @notifications=Notification.all
    @notification=Notification.new
  end

  # GET /orders/1/edit
  def edit
  end
  def complete
    @order=Order.find(params[:id])
    @order.status = "Finished"
   @order.save
  end
  # POST /orders
  # POST /orders.json
  def create
    puts "test000"
    invited= params[:friends_invited]

    puts params.inspect
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.invited = invited.length
    @order.joined = 0
    @order.status = "waiting"
    respond_to do |format|
      if @order.save

        invited.each do |i|
          @group_invited = Group.where(name: i)
          @user_invited = User.where(name: i)
          if(@group_invited.present?)
            puts "test-group"
            @group_id = @group_invited.ids
            puts @group_id
            @members = UserGroup.where(group_id: @group_id).all
            puts @members.inspect
            @members.each do |m|
              @group_invite = OrderDetail.new
              @group_invite.user_id = m.user_id
              @group_invite.order_id = @order.id
              @group_invite.joined = 0
              puts @group_invite.inspect
              if @group_invite.save
                puts "Group Invited"
              end
            end
          else
            puts "test-user"
            user_invs = OrderDetail.new
            puts @user_invited.ids.class
            user_invs.user_id = @user_invited.ids[0]
            user_invs.order_id = @order.id
            puts user_invs.user_id
            user_invs.joined = 0
            puts user_invs.inspect
            if user_invs.save
              puts "User Invited"
            end
          end
        end
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }

        ##################################### test pusher####################################
        Pusher.trigger('my-channel', 'my-event', {
            message: current_user.name.to_s<<" invited  "<<invited.join(",")<<" to "<<@order.meal,
            id: @order.id
        })
        ##################################### test pusher####################################
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
      @order.user_id = current_user.id
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:meal, :user_id, :group_id, :restaurant, :joined, :invited, :status, :image, :order_image)
    end
end
