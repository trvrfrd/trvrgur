class RenameUpvoteAndDownvoteColumns < ActiveRecord::Migration
  def change
    rename_column :albums, :upvotes, :upvote_count
    rename_column :albums, :downvotes, :downvote_count

    rename_column :comments, :upvotes, :upvote_count
    rename_column :comments, :downvotes, :downvote_count
  end
end
