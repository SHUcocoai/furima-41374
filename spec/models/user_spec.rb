require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'passwordは5文字以下では登録できない' do
        @user.password = 'pass1'
        @user.password_confirmation = 'pass1'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'pass124'
        @user.password_confirmation = 'pass123'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'passpa'
        @user.password_confirmation = 'passpa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password must contain at least one letter and one number'
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password must contain at least one letter and one number'
      end
      it '全角文字を含むpasswordでは登録できない' do
        @user.password = 'パス1234'
        @user.password_confirmation = 'パス1234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password must contain at least one letter and one number'
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name must be entered using full-width characters (hiragana, katakana, or kanji)'
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でない場合は登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name must be entered using full-width characters (hiragana, katakana, or kanji)'
      end
      it 'last_name_kanaが全角（カタカナ）でない場合は登録できない' do
        @user.last_name_kana = 'やま田'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana must be entered using full-width katakana characters'
      end
      it 'first_name_kanaが全角（カタカナ）でない場合は登録できない' do
        @user.first_name_kana = 'た郎'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana must be entered using full-width katakana characters'
      end
    end
  end
end
