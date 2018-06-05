class AddPublishedAtAndModifiedAtToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :published_at, :datetime
    add_column :articles, :modified_at, :datetime
  end
end
