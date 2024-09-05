class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end
  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    if @order_shipping_address.valid?
      pay_item
       @order_shipping_address.save #ここでフォームオブジェクトで保存したorderとshipping_addressが保存されている。記述順でいうと決済処理後となるためストロングパラメーターにはorderは入らない。
       redirect_to root_path
    else 
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private
  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_shipping_address_params[:token],
        currency: 'jpy'
      )
  end
end
