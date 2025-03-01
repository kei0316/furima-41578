FactoryBot.define do
  require 'faker'

  FactoryBot.define do
    factory :user do
      nickname { "テスト" }
      email { "test@example.com" }
      password { "password1" }
      password_confirmation { "password1" }
      last_name { "山田" }
      first_name { "太郎" }
      last_name_kana { "ヤマダ" }
      first_name_kana { "タロウ" }
      birthdate { "2000-01-01" }
    end
  end
  
end  