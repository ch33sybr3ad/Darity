class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :likes_count, default: 0
      t.integer :author_id
      t.integer :dare_id

      t.timestamps null: false
    end
  end
end
