module Archivable
    extend ActiveSupport::Concern
  
    included do
      has_many :archives, dependent: :destroy
  
      def archive!
        archives.create(user: Current.user)
      end
  
      def unarchive!
        archive.destroy
      end
  
      def archive
        archives.find_by(user: Current.user)
      end
    end
  end