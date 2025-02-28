FactoryBot.define do
  require 'faker'

  FactoryBot.define do
    factory :user do
      nickname              { Faker::Name.initials(number: 2) }
      email                 { Faker::Internet.email }
      password              { Faker::Internet.password(min_length: 6) }
      password_confirmation { password }
    end  # この行でファクトリブロックを閉じます
  end  # この行で FactoryBot ブロックを閉じます
end  