class AddPublishedAtAndModifiedAtToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :published_at, :datetime
    add_column :articles, :modified_at, :datetime
  end
end
