class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :provider
      t.string :uid
      t.string :image_url
      t.boolean :admin, default: false
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at

      t.timestamps null: false
    end
  end
end
