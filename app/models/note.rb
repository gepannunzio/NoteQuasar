class Note < ApplicationRecord

    validates :title, presence: true 
    validates :body, presence: true

    has_and_belongs_to_many :tag
end
