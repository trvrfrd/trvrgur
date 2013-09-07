class CreateUserCommentUpvotes < ActiveRecord::Migration
  def change
    create_table :user_comment_upvotes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.timestamps
    end

    add_index :user_comment_upvotes, [:user_id, :comment_id], :unique => true
    add_index :user_comment_upvotes, [:comment_id, :user_id], :unique => true
  end
end
