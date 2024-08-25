class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password, format: { 
    with: /\A(?=.*?[a-zA-Z])(?=.*?[\d])[a-zA-Z\d]+\z/i, 
    message: "は半角英字と数字をそれぞれ1文字以上含む必要があります"
  }

  with_options presence: { message: "を入力してください" },
             format: { 
               with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, 
               message: "は全角文字（ひらがな、カタカナ、漢字）で入力してください"
             } do
    validates :last_name
    validates :first_name
  end

  with_options presence: { message: "を入力してください" },
             format: { 
               with: /\A[ァ-ヶ]+\z/, 
               message: "は全角文字（カタカナ）で入力してください"
             } do
    validates :last_name_kana
    validates :first_name_kana
  end

  validates :birth_date, presence: true
end
