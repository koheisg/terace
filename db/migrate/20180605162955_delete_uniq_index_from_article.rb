class DeleteUniqIndexFromArticle < ActiveRecord::Migration[6.0]
  def change
    remove_index :articles, column: ["permalink", "user_id"]
  end
end
