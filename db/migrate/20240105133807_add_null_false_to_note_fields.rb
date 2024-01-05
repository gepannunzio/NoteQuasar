class AddNullFalseToNoteFields < ActiveRecord::Migration[7.1]
  def change
    change_column_null :notes, :title, false
    change_column_null :notes, :body, false
  end
end
