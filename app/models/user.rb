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
end
