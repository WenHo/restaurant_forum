class Restaurant < ApplicationRecord
	validates_presence_of :name
	mount_uploader :image, PhotoUploader
	belongs_to :category, optional: true
	# 與使用者建立關聯，評論餐廳
	has_many :comments, dependent: :destroy
	# 與使用者建立關聯，收藏餐廳
	has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  # 與使用者建立關係，喜歡
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  def is_liked?(user)
    self.liked_users.include?(user)
  end
end
