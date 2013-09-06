class ChangeDescriptionsToText < ActiveRecord::Migration
  def change
    change_column :images, :description, :text
    change_column :albums, :description, :text
  end
end
