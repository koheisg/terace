class AddArchiveableToArchive < ActiveRecord::Migration[6.0]
  def change
    add_reference :archives, :archiveable, polymorphic: true
  end
end
