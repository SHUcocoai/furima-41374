class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "enter in the format '3 digits-4 digits'." }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'enter a half-width number between 10 and 11 digits.' }
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'must be selected' }

  def save
    order = Order.create(user_id:, item_id:)

    ShippingAddress.create(postal_code:, prefecture_id:, city:, street_address:,
                           building_name:, phone_number:, order_id: order.id)
  end
end
