class DropArticleCoumns < ActiveRecord::Migration[6.0]
  def change
    remove_columns(:articles, :user_id, :site_id, :state, :permalink, :title, :description, :noindex, :published_at, :modified_at)
  end
end
