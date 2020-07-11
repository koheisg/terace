class AddCategoryToPermalink < ActiveRecord::Migration[6.0]
  def change
    add_reference :permalinks, :category, foreign_key: true
  end
end
