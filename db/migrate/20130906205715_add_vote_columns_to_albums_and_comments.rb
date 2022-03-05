class AddVoteColumnsToAlbumsAndComments < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :upvotes, :integer, :default => 0
    add_column :albums, :downvotes, :integer, :default => 0

    add_column :comments, :upvotes, :integer, :default => 0
    add_column :comments, :downvotes, :integer, :default => 0
  end
end
