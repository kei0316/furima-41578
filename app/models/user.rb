class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  validates :birthdate, presence: true
  
  validates :last_name, :first_name, presence: true, format: { with:/\A[ぁ-んァ-ン一-龥々ーヶ]+\z/, message: 'can only include hiragana, katakana, and kanji characters' }
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u3000ー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :password, format: { with: /\A(?=.*\d)(?=.*[a-zA-Z]).*\z/, message: 'must include both letters and numbers.' }
end
