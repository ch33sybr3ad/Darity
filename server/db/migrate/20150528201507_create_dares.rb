class CreateDares < ActiveRecord::Migration
  def change
    create_table :dares do |t|
      t.string :title
      t.text :description
      t.integer :proposer_id

      t.timestamps null: false
    end
  end
end
