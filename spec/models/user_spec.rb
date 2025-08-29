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
        expect(user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'メールアドレスが必須' do
        user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include('Eメールを入力してください')
      end

      it 'メールアドレスが一意である（重複は無効）' do
        create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        user.valid?
        expect(user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'メールアドレスは@を含む' do
        user.email = 'invalid.email.example.com'
        user.valid?
        expect(user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'パスワードが必須' do
        user.password = ''
        user.password_confirmation = ''
        user.valid?
        expect(user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'パスワードは6文字以上' do
        user.password = 'a1b2c'
        user.password_confirmation = 'a1b2c'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードは半角英数字混合（数字のみは無効）' do
        user.password = '123456'
        user.password_confirmation = '123456'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードは半角英数字混合（英字のみは無効）' do
        user.password = 'abcdef'
        user.password_confirmation = 'abcdef'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードは半角英数字混合（全角を含むと無効）' do
        user.password = 'ａｂｃ１２３'
        user.password_confirmation = 'ａｂｃ１２３'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードとパスワード（確認）が一致しないと無効' do
        user.password = 'abc123'
        user.password_confirmation = 'abc124'
        user.valid?
        expect(user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end

    context '新規登録/本人情報確認' do
      it 'お名前(全角)は名字が必須' do
        user.last_name = ''
        user.valid?
        expect(user.errors.full_messages).to include('名字を入力してください')
      end

      it 'お名前(全角)は名前が必須' do
        user.first_name = ''
        user.valid?
        expect(user.errors.full_messages).to include('名前を入力してください')
      end

      it 'お名前(全角)は全角（漢字・ひらがな・カタカナ）以外は無効（半角英字）' do
        user.last_name = 'Yamada'
        user.first_name = 'Taro'
        user.valid?
        expect(user.errors.full_messages).to include('名字は全角（漢字・ひらがな・カタカナ）で入力してください')
        expect(user.errors.full_messages).to include('名前は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'お名前カナ(全角)は名字が必須' do
        user.last_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include('名字カナを入力してください')
      end

      it 'お名前カナ(全角)は名前が必須' do
        user.first_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include('名前カナを入力してください')
      end

      it 'お名前カナ(全角)は全角カタカナ以外は無効（ひらがな）' do
        user.last_name_kana = 'やまだ'
        user.first_name_kana = 'たろう'
        user.valid?
        expect(user.errors.full_messages).to include('名字カナは全角カタカナで入力してください')
        expect(user.errors.full_messages).to include('名前カナは全角カタカナで入力してください')
      end

      it 'お名前カナ(全角)は全角カタカナ以外は無効（半角英数）' do
        user.last_name_kana = 'YAMADA'
        user.first_name_kana = 'TARO'
        user.valid?
        expect(user.errors.full_messages).to include('名字カナは全角カタカナで入力してください')
        expect(user.errors.full_messages).to include('名前カナは全角カタカナで入力してください')
      end

      it '生年月日が必須' do
        user.birth_date = nil
        user.valid?
        expect(user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
