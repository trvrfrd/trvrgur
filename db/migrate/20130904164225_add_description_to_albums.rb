class AddDescriptionToAlbums < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :description, :string
  end
end
