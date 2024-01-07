class AddNotNullToCategoryName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tags, :name, false
  end
end
