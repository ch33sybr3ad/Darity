class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :comment_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
