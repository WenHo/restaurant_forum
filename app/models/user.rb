class User < ApplicationRecord
  # 建立多對多的關係，評論
	has_many :comments, dependent: :restrict_with_error
	has_many :restaurants, through: :comments

  # 建立多對多的關係，收藏
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  # 更改名稱，來源為model_restaurant
  #建立多對多關係，喜歡
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes , source: :likes
  #建立追蹤關係
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  #被誰追蹤
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id" #主鍵指向following_id
  has_many :followers, through: :inverse_followships, source: :user
  #建立朋友關係
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  # 被誰加朋友
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id" 
  has_many :myfriends, through: :inverse_friendships, source: :user

  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end
  def following?(user)
    self.followings.include?(user)
  end
  def friend?(user)
    self.friends.include?(user) || self.friends.include?(user)
  end
  def all_friends
    friends = self.friends + self.myfriends
    return friends.uniq
  end
end
