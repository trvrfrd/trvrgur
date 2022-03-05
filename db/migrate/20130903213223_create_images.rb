class CreateImages < ActiveRecord::Migration[4.2]
  def change
    create_table :images do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.attachment :file

      t.timestamps
    end
  end
end
