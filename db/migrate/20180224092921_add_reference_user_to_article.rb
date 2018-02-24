class AddReferenceUserToArticle < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :user
  end
end
