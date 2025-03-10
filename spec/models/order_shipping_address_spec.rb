require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: @user.id, item_id: @item.id)
  end

  describe '配送先の住所情報のバリデーション' do
    context '配送先情報が正しく入力されている場合' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect(@order_shipping_address).to be_valid
      end

      it '建物名は空でも保存できる' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '配送先情報に問題がある場合' do
      it '郵便番号が空では保存できない' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンが含まれていないと保存できない' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code must be in the format 123-4567")
      end

      it '都道府県が空では保存できない' do
        @order_shipping_address.prefecture_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県が「---」では保存できない' do
        @order_shipping_address.prefecture_id = '---'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '市区町村が空では保存できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できない' do
        @order_shipping_address.address_line = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Address line can't be blank")
      end

      it '電話番号が空では保存できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満では保存できない' do
        @order_shipping_address.phone_number = '123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number must be 10 to 11 digits")
      end

      it '電話番号が12桁以上では保存できない' do
        @order_shipping_address.phone_number = '123456789012'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number must be 10 to 11 digits")
      end

      it '電話番号にハイフンが含まれていると保存できない' do
        @order_shipping_address.phone_number = '090-1234-5678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number must be 10 to 11 digits")
      end

      it 'トークンが空では保存できない' do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では保存できない' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では保存できない' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
