class AddDareeIdtoDares < ActiveRecord::Migration
  def change
    add_column :dares, :daree_id, :integer
  end
end
