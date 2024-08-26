class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :shipping_date

  validates :image, presence: true
  validates :item_name, presence: true
  validates :description, presence: true
  validates :item_category_id, presence: true
  validates :item_status_id, presence: true
  validates :shipping_fee_status_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_date_id, presence: true
  validates :price, presence: true
  validates :item_category_id, numericality: { other_than: 1, message: "Item category can't be blank" }
  validates :item_status_id, numericality: { other_than: 1, message: "Item status can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "Shipping fee status can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "Prefecture can't be blank" }
  validates :shipping_date_id, numericality: { other_than: 1, message: "Shipping date can't be blank" }
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
