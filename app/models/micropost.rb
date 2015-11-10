class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  
   mount_uploader :image, ImageUploader
end
