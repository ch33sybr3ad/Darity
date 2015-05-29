class CreateDares < ActiveRecord::Migration
  def change
    create_table :dares do |t|
      t.string :title
      t.string :description
      t.integer :daree_id
      t.integer :proposer_id
      t.integer :charity_id
      t.boolean :done, default: false

      t.timestamps null: false
    end
  end
end
