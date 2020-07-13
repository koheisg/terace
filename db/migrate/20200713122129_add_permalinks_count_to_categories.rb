class AddPermalinksCountToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :permalinks_count, :integer
  end
end
