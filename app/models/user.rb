class User < ActiveRecord::Base
    
    # データの保存前にメールアドレスのアルファベットを小文字にする。
    # before_saveはコールバックと呼ばれ、データの保存が行われる前に、
    # 指定したブロックまたは、メソッドの処理が実行される。
    before_save { self.email = email.downcase }
    # ********************************validation
    validates :name, presence: true, length: { maximum: 50}
    # 正規表現パターンを定義している
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # emailは空でなく、255文字以内で、VALID_EMAIL_REGEXのパターンに一致
    validates :email, presence: true, length: { maximum: 255},
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    
    
    # ********************************password
    # - データベースに安全にハッシュ化（暗号化）されたpassword_digestを保存する。
    # - passwordとpassword_confirmationをモデルに追加してパスワードが一致するか検証する。
    # - パスワードが正しい時、ユーザーを返すauthenticate(信頼できるという意味)メソッドを提供する。
    has_secure_password
    
    has_many :microposts
    

    has_many :following_relationships, class_name: "Relationship",
                                       foreign_key: "follower_id",
                                       dependent: :destroy
    has_many :following_users, through: :following_relationships, source: :followed

    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower                                  
    
    has_many :likes
    has_many :liked_posts, through: :likes, source: :micropost
    
    
    # 他の人をフォローする
    def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
    end
    def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
    end
    def following?(other_user)
        following_users.include?(other_user)
    end
    

    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    def number_followings
        following_relationships.count
    end
    def number_followers
        follower_relationships.count
    end
    
    
    def like(other_post)
        likes.create(micropost_id: other_post.id)
    end
    def unlike(other_post)
        likes.find_by(micropost_id: other_post.id).destroy
    end
    def liking?(other_post)
        liked_posts.include?(other_post)
    end
end
