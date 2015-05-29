class AddDonationAmounttoDonations < ActiveRecord::Migration
  def change
    add_column :donations, :donation_amount, :integer
  end
end
