require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが6文字以上でなければ登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合でなければ登録できない' do
        @user.password = '12345678' # 数字のみ
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers.')

        @user.password = 'abcdefgh' # 英字のみ
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers.')

        @user.password = 'パスワード123' # 全角文字を含む
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers.')
      end

      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '苗字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '名前カナが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '苗字カナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '名前カナにカタカナ以外が含まれると登録できない' do
        @user.first_name_kana = 'あいうえお' # 全角ひらがな
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')

        @user.first_name_kana = 'アイウエオ' # カタカナ
        expect(@user).to be_valid # カタカナは有効

        @user.last_name_kana = 'あいうえお' # 全角ひらがな
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')

        @user.last_name_kana = 'アイウエオ' # カタカナ
        expect(@user).to be_valid # カタカナは有効
      end

      it '生年月日が空では登録できない' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end

      it 'last_nameにひらがな・カタカナ・漢字以外が含まれると登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name can only include hiragana, katakana, and kanji characters')

        @user.last_name = 'やまだ'
        expect(@user).to be_valid # ひらがなは有効

        @user.last_name = 'ヤマダ'
        expect(@user).to be_valid # カタカナは有効

        @user.last_name = '山田'
        expect(@user).to be_valid # 漢字は有効

        @user.last_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name can only include hiragana, katakana, and kanji characters')
      end

      it 'first_nameにひらがな・カタカナ・漢字以外が含まれると登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name can only include hiragana, katakana, and kanji characters')

        @user.first_name = 'たろう'
        expect(@user).to be_valid # ひらがなは有効

        @user.first_name = 'タロウ'
        expect(@user).to be_valid # カタカナは有効

        @user.first_name = '太郎'
        expect(@user).to be_valid # 漢字は有効

        @user.first_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name can only include hiragana, katakana, and kanji characters')
      end
    end
  end
end
