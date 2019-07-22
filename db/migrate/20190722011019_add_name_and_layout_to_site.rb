class AddNameAndLayoutToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :name, :string
    add_column :sites, :layout, :integer
  end
end
