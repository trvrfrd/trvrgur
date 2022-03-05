class ChangeDescriptionsToText < ActiveRecord::Migration[4.2]
  def change
    change_column :images, :description, :text
    change_column :albums, :description, :text
  end
end
