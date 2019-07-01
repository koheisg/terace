class AddSiteToArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :site, foreign_key: true
  end
end
