class AddOgImageUrlToPermalink < ActiveRecord::Migration[6.1]
  def change
    add_column :permalinks, :og_image_url, :string
  end
end
