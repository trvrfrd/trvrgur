class CreateAlbums < ActiveRecord::Migration[4.2]
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end

    add_index :albums, :user_id
  end
end
