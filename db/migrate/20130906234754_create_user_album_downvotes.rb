class CreateUserAlbumDownvotes < ActiveRecord::Migration[4.2]
  def change
    create_table :user_album_downvotes do |t|
      t.integer :user_id
      t.integer :album_id
      t.timestamps
    end

    add_index :user_album_downvotes, [:user_id, :album_id], :unique => true
    add_index :user_album_downvotes, [:album_id, :user_id], :unique => true
  end
end
