class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :parent_comment_id
      t.integer :album_id, :null => false
      t.text :body, :null => false
      t.integer :author_id ,:null => false

      t.timestamps
    end

    add_index :comments, :parent_comment_id
    add_index :comments, :album_id
    add_index :comments, :author_id
  end
end
