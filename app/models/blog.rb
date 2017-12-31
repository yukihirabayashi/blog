class Blog < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :title, presence: true
    validates :content, presence: true,
                        length: { minimum: 1, maximum: 140 }

end
