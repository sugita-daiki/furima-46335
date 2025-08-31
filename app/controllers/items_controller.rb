class ItemsController < ApplicationController
  def index
    @items = @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to ''
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image).merge(user_id: current_user.id)
  end
end
