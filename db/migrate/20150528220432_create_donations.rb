class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :pledger_id
      t.integer :pledged_dare_id
      t.integer :approve #for = 1, against = 0, abstain = nil

      t.timestamps null: false
    end
  end
end
