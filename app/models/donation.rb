class Donation < ActiveRecord::Base
  belongs_to :user, foreign_key: "pledger_id"
  belongs_to :dare, foreign_key: "pledged_dare_id"

  validates_presence_of :pledger_id, :pledged_dare_id, :donation_amount
  validates :donation_amount, numericality: true

end
