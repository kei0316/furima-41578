class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true,format: { 
    with: /\A[\p{katakana}\u3000ー－]+\z/,
  }

  validates :first_name_kana, presence: true,format: { 
    with: /\A[\p{katakana}\u3000ー－]+\z/, 
  }
  validates :birthdate, presence: true
  
  validates :password, format: { 
    with: /\A(?=.*\d)(?=.*[a-zA-Z]).{6,}\z/, 
  }
  
end
