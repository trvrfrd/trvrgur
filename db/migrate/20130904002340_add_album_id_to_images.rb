class AddAlbumIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :album_id, :integer
    add_index :images, :album_id
    add_index :images, :user_id
  end
end
