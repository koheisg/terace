class DeleteUniqIndexFromArticle < ActiveRecord::Migration[5.2]
  def change
    remove_index :articles, column: ["permalink", "user_id"]
  end
end
