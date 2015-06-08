class Dare < ActiveRecord::Base
  has_many :donations, foreign_key: "pledged_dare_id"
  has_many :pledgers, through: :donations, source: :user
  has_one :video
  has_many :comments

  belongs_to :proposer, foreign_key: :proposer_id, class_name: "User"
  belongs_to :daree, foreign_key: :daree_id, class_name: "User"
  belongs_to :charity

  validates_presence_of :title, :description, :proposer_id, :daree_id
  validates :price, allow_nil: true, numericality: true

  def pledged
    donations.inject(0) { |sum, donation| sum + donation.donation_amount }
  end
end

