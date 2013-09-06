class CreateUserAlbumVotes < ActiveRecord::Migration
  def change
    create_table :user_album_votes do |t|
      t.integer :user_id, :null => false
      t.integer :album_id, :null => false
      t.integer :value, :null => false

      t.timestamps
    end
    add_index :user_album_votes, [:user_id, :album_id], :unique => true
    add_index :user_album_votes, [:album_id, :user_id], :unique => true
  end
end
