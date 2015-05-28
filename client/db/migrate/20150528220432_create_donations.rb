class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :pledger_id
      t.integer :pledged_dare_id

      t.timestamps null: false
    end
  end
end
