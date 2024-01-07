class Archive < ApplicationRecord

  validates :user, uniqueness: { scope: :note }

  belongs_to :user
  belongs_to :note
end
