class User < ApplicationRecord
    
    has_many :blogs
  
    has_many :favorites, dependent: :destroy
    has_many :favorite_blogs, through: :favorites, source: :blog
    
    # Carrierwaveの画像表示
    mount_uploader :icon, ImageUploader
      
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
        format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

      attr_accessor :remember_token
      
      before_save { self .email = email.downcase }
      
       validates :name,  presence: true, length: { maximum: 50 }
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
      
      has_secure_password
      validates :password, presence: true, length: { minimum: 6 }
      
      # 渡された文字列のハッシュ値をかえす。
      def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
    
    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # 永続セッションのためにユーザーをDBに記録する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
     
     # ユーザーのログイン情報の破棄
    def forget
        update_attribute(:remember_digest, nil)
    end

      
end
