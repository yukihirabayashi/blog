class Blog < ApplicationRecord
    
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    belongs_to :user,optional: true
        
    validates :name, presence: true
    validates :title, presence: true
    validates :content, presence: true,
                        length: { minimum: 1, maximum: 140 }
                        
    mount_uploader :image, ImageUploader
end
