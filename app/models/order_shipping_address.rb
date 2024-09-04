class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :order, :user_id, :item_id

  with_options presence: true do 
  validates :postal_code, format: {with: /\A\d{3}-\d{4}\z/, message: "enter in the format '3 digits-4 digits'." }
  validates :city
  validates :street_address
  validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "enter a half-width number between 10 and 11 digits."}
  validates :user_id
  validates :item_id
  end
  
  validates :prefecture_id, numericality: { other_than: 1, message: "must be selected"}
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

