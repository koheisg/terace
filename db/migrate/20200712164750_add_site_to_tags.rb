class AddSiteToTags < ActiveRecord::Migration[6.0]
  def change
    add_reference :tags, :site, null: false, foreign_key: true, default: 1
  end
end
