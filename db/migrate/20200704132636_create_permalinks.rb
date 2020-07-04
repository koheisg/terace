class CreatePermalinks < ActiveRecord::Migration[6.0]
  def change
    create_table :permalinks do |t|
      t.references :permalinkable, polymorphic: true, null: false
      t.references :site, null: false, foreign_key: true
      t.integer "state"
      t.string :path
      t.string :title
      t.string :description
      t.boolean :noindex
      t.datetime :published_at
      t.datetime :modified_at

      t.timestamps
    end
  end
end
