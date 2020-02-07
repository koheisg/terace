class AddNoIndexToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :noindex, :boolean, null: false, default: false
  end
end
