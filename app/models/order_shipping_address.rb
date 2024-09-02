class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, prefecture_id, city, street_address, building_name, phone_number, user, item, order

  with_options presence: true do 
  validates :postal_code, format {with: \A\d{3}-\d{4}\z, message: "enter in the format '3 digits-4 digits'." }
  validates :prefecture_id
  validates :city
  validates :street_address
  validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "enter a number between 10 and 11 digits.}
  validates :user_id
  end
  
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user: use, , item: item)
    
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, order_id: order.id)
end
