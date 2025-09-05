require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end
  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it '正常な値が入力された場合は保存できる' do
        expect(@order_address).to be_valid
      end

      it 'buildingが空の場合は保存できる' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end
    context '内容に問題がある場合' do
      it 'postal_codeが空の場合は保存できない' do
        @order_address.postal_code = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end

      it 'postal_codeがハイフンなしの場合は保存できない' do
        @order_address.postal_code = '1234567'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postal_code]).to include('is invalid. Include hyphen(-)')
      end

      it 'postal_codeの桁数が足りない場合は保存できない' do
        @order_address.postal_code = '12-3456'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postal_code]).to include('is invalid. Include hyphen(-)')
      end

      it 'postal_codeに文字が含まれている場合は保存できない' do
        @order_address.postal_code = '123-456a'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:postal_code]).to include('is invalid. Include hyphen(-)')
      end

      it 'prefecture_idが空の場合は保存できない' do
        @order_address.prefecture_id = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'prefecture_idが0の場合は保存できない' do
        @order_address.prefecture_id = 0
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'cityが空の場合は保存できない' do
        @order_address.city = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:city]).to include("can't be blank")
      end

      it 'blockが空の場合は保存できない' do
        @order_address.block = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:block]).to include("can't be blank")
      end

      it 'phone_numberが空の場合は保存できない' do
        @order_address.phone_number = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include("can't be blank")
      end

      it 'phone_numberの桁数が足りない場合は保存できない' do
        @order_address.phone_number = '090123456'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it 'phone_numberの桁数が多い場合は保存できない' do
        @order_address.phone_number = '090123456789'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it 'phone_numberにハイフンが含まれている場合は保存できない' do
        @order_address.phone_number = '090-1234-5678'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end

      it 'user_idが空の場合は保存できない' do
        @order_address.user_id = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空の場合は保存できない' do
        @order_address.item_id = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:item_id]).to include("can't be blank")
      end

      it 'tokenが空の場合は保存できない' do
        @order_address.token = ''
        expect(@order_address).not_to be_valid
        expect(@order_address.errors[:token]).to include("can't be blank")
      end
    end
  end
end
