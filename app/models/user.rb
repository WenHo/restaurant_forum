class User < ApplicationRecord
  # 建立多對多的關係，評論
	has_many :comments, dependent: :restrict_with_error
	has_many :restaurants, through: :comments

  # 建立多對多的關係，收藏
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites , source: :restaurants
  # 更改名稱，來源為model_restaurant
  #建立多對多關係，喜歡
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes , source: :likes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end
end
