class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end
  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    if @order_shipping_address.valid?
      Payjp.api_key = "sk_test_c37d1222b17a33dad4041da7"
      Payjp::Charge.create(
        amount: @item.price,
        card: order_shipping_address_params[:token],
        currency: 'jpy'
      )
       @order_shipping_address.save
       redirect_to root_path
    else 
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private
  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :order).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end
end
