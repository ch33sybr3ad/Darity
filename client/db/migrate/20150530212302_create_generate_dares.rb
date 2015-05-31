class CreateGenerateDares < ActiveRecord::Migration
  def change
    create_table :generate_dares do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
