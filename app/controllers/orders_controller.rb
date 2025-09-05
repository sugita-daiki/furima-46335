class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params.merge(user_id: current_user.id, item_id: @item.id))
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :block, :building,
                                          :phone_number, :token)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
