class ChangeArchiveableNotNullToArchive < ActiveRecord::Migration[6.0]
  def change
    change_column_null :archives, :archiveable_id, false
    change_column_null :archives, :archiveable_type, false
  end
end
