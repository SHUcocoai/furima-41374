require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '購入できるとき' do
      it 'postal_codeとprefecture_id 、cityとstreet_address、phone_numberとtokenが存在すれば登録できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'building_nameが空でも保存できる' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end
    context '購入できないとき' do
      it 'postal_codeが空では購入できない' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Postal code can't be blank"
      end
      it 'prefecture_idが空では購入できない' do
        @order_shipping_address.prefecture_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Prefecture must be selected'
      end
      it 'cityが空では購入できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "City can't be blank"
      end
      it 'street_addressが空では購入できない' do
        @order_shipping_address.street_address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Street address can't be blank"
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'potal_codeが3桁ハイフン4桁でないと購入できない' do
        @order_shipping_address.postal_code = '1234-567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Postal code enter in the format '3 digits-4 digits'."
      end
      it 'potal_codeが半角でないと購入できない' do
        @order_shipping_address.postal_code = '１２３-４５６７'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Postal code enter in the format '3 digits-4 digits'."
      end
      it 'potal_codeが文字列でないと購入できない' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Postal code enter in the format '3 digits-4 digits'."
      end
      it 'phone_numberが10桁以上11桁以内でないと購入できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number enter a half-width number between 10 and 11 digits.'
      end
      it 'phone_numberが9桁以下だと購入できない' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number enter a half-width number between 10 and 11 digits.'
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number enter a half-width number between 10 and 11 digits.'
      end
      it 'phone_numberが半角でないと購入できない' do
        @order_shipping_address.phone_number = '０９０１２３４５６７８'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number enter a half-width number between 10 and 11 digits.'
      end
      it 'phone_numberが数値でないと購入できない' do
        @order_shipping_address.phone_number = '09-123-5678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include 'Phone number enter a half-width number between 10 and 11 digits.'
      end
      it 'userが紐づいていないと購入できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "User can't be blank"
      end
      it 'itemが紐づいていないと購入できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Item can't be blank"
      end
      it 'tokenが空では購入できない' do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include "Token can't be blank"
      end
    end
  end
end
