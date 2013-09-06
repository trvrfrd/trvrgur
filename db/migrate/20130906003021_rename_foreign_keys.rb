class RenameForeignKeys < ActiveRecord::Migration
  def change
    rename_column :albums, :user_id, :creator_id
    rename_column :images, :user_id, :uploader_id
  end
end
