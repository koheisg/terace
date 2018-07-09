class AddSiteToArticle < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :site, foreign_key: true
  end
end
