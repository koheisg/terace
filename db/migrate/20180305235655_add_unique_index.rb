class AddUniqueIndex < ActiveRecord::Migration[6.0]
  def change
    add_index(:tags, :name, unique: true)
    add_index(:articles, [:permalink, :user_id], unique: true)
  end
end
