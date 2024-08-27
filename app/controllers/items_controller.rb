class ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end


  private

  def item_params
    prams.require(:item).permit(:image, :item_name, :description, :item_category_id, :item_status_id, :shipping_fee_status_id, :prefecture_id, :shipping_date_id, :price ).merge(user_id: current_user.id)
  end
end

