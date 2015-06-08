class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.string :url
      t.text :mission
      t.string :transparency_score

      t.timestamps null: false
    end
  end
end
