class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :likes, default: 0
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
