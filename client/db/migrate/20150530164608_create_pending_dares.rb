class CreatePendingDares < ActiveRecord::Migration
  def change
    create_table :pending_dares do |t|
      t.string :title
      t.string :description
      t.integer :daree_id
      t.integer :proposer_id
      t.string :twitter_handle

      t.timestamps null: false
    end
  end
end
