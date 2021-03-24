require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要な情報が正しく入力されているとき登録できる' do
        expect(@user).to be_valid
      end
      it 'passwrodは半角英数混合で6文字以上のとき登録できる' do
        @user.password = 'abcde1'
        @user.password_confirmation = 'abcde1'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nicknameを入力してください"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end

      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it '重複したemailが存在する時登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'aaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end

      it 'passwordが5文字以下だと登録できない' do
        @user.password = 'abcd1'
        @user.password_confirmation = 'abcd1'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end

      it 'passwordとpassword_confirmationが不一致だと登録できない' do
        @user.password = 'abcde1'
        @user.password_confirmation = 'efghi2'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'passwordに英字が含まれていない場合登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは不正な値です'
      end

      it 'passwordに数字が含まれていない場合登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end

      it 'passwordに全角が含まれている場合登録できない' do
        @user.password = 'ＡＢＶＤＥＴ１'
        @user.password_confirmation = 'ＡＢＶＤＥＴ１'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
    end
  end
end
