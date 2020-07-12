class ChangeDefaultSiteIdOnTags < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:tags, :site_id, from: 1, to: nil)
  end
end
