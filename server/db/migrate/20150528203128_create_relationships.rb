class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :pledger_id
      t.integer :dare_id

      t.timestamps null: false
    end
  end
end
