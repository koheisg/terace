class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.references :tags, foreign_key: true
      t.references :taggable, polymorphic: true

      t.timestamps
    end
  end
end
