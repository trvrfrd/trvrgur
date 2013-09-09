class CreateUserAlbumFavorites < ActiveRecord::Migration
  def change
    create_table :user_album_favorites do |t|
      t.integer :user_id
      t.integer :album_id

      t.timestamps
    end
    add_index :user_album_favorites, [:user_id, :album_id], :unique => true
    add_index :user_album_favorites, [:album_id, :user_id], :unique => true
  end
end
