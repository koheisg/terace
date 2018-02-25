class AddStateToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :state, :integer
  end
end
