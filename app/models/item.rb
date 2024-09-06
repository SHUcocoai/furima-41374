class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :shipping_date
  has_one :order

  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :item_category_id
    validates :item_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :shipping_date_id
    validates :price
  end
  with_options numericality: { other_than: 1, message: 'must be selected' } do
    validates :item_category_id
    validates :item_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :shipping_date_id
  end

  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'must be a half-width number between 300 and 9,999,999' }
end
