require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    let(:user) { build(:user) }

    it 'すべての項目が正しければ有効' do
      expect(user).to be_valid
    end

    context '新規登録/ユーザー情報' do
      it 'ニックネームが必須' do
        user.nickname = ''
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが必須' do
        user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意である（重複は無効）' do
        create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        user.valid?
        expect(user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは@を含む' do
        user.email = 'invalid.email.example.com'
        user.valid?
        expect(user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが必須' do
        user.password = ''
        user.password_confirmation = ''
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは6文字以上' do
        user.password = 'a1b2c'
        user.password_confirmation = 'a1b2c'
        user.valid?
        expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは半角英数字混合（数字のみは無効）' do
        user.password = '123456'
        user.password_confirmation = '123456'
        user.valid?
        expect(user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'パスワードは半角英数字混合（英字のみは無効）' do
        user.password = 'abcdef'
        user.password_confirmation = 'abcdef'
        user.valid?
        expect(user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'パスワードは半角英数字混合（全角を含むと無効）' do
        user.password = 'ａｂｃ１２３'
        user.password_confirmation = 'ａｂｃ１２３'
        user.valid?
        expect(user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'パスワードとパスワード（確認）が一致しないと無効' do
        user.password = 'abc123'
        user.password_confirmation = 'abc124'
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context '新規登録/本人情報確認' do
      it 'お名前(全角)は名字が必須' do
        user.last_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'お名前(全角)は名前が必須' do
        user.first_name = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前(全角)は全角（漢字・ひらがな・カタカナ）以外は無効（半角英字）' do
        user.last_name = 'Yamada'
        user.first_name = 'Taro'
        user.valid?
        expect(user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
        expect(user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end

      it 'お名前カナ(全角)は名字が必須' do
        user.last_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'お名前カナ(全角)は名前が必須' do
        user.first_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'お名前カナ(全角)は全角カタカナ以外は無効（ひらがな）' do
        user.last_name_kana = 'やまだ'
        user.first_name_kana = 'たろう'
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
        expect(user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end

      it 'お名前カナ(全角)は全角カタカナ以外は無効（半角英数）' do
        user.last_name_kana = 'YAMADA'
        user.first_name_kana = 'TARO'
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
        expect(user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end

      it '生年月日が必須' do
        user.birth_date = nil
        user.valid?
        expect(user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
