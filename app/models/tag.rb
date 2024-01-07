class Tag < ApplicationRecord
    validates :name, presence: true, length: { maximum: 10 }
    has_and_belongs_to_many :notes, dependent: :restrict_with_exception
    belongs_to :user, default: -> { Current.user }
end
