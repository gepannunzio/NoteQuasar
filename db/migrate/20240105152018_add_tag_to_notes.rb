class AddTagToNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes_tags, id: false do |t|
      t.belongs_to :note
      t.belongs_to :tag
    end
  end
end
