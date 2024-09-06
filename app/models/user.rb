class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders
  validates :nickname, presence: true
  validates :password,
            format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/i,
                      message: 'must contain at least one letter and one number' }

  validates :last_name, :first_name, presence: true,
                                     format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'must be entered using full-width characters (hiragana, katakana, or kanji)' }

  validates :last_name_kana, :first_name_kana, presence: true,
                                               format: { with: /\A[ァ-ヶー]+\z/, message: 'must be entered using full-width katakana characters' }
  validates :birth_date, presence: true
end
