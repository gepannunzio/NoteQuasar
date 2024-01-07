class Note < ApplicationRecord
    include PgSearch::Model
    include Archivable

    pg_search_scope :search_full_text, against: {
        title: 'A',
        body: 'B',
    }


    validates :title, presence: true, length: { maximum: 45 }
    validates :body, presence: true

    has_many :archives, dependent: :destroy
    has_and_belongs_to_many :tags
    belongs_to :user, default: -> { Current.user }

    def owner?
        user_id == Current.user&.id
    end

end
