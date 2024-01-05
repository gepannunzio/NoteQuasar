class Tag < ApplicationRecord

    has_and_belongs_to_many :notes, dependent: :restrict_with_exception
end
