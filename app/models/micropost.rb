class Micropost < ActiveRecord::Base
  belongs_to :user
#   ユーザのidが存在する。
  validates :user_id, presence: true
#   contentが存在し、また文字数は最大140
  validates :content, presence: true, length: { maximum: 140 }
end
