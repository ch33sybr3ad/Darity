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
  # validates :approve, 
  #           allow_nil: true,
  #           numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  def pledged
    donations.inject(0) { |sum, donation| sum + donation.donation_amount }
  end

  def approval_rate
    approvals = donations.where(approve: 1).count
    votes = donations.where("approve is not null").count
    return approvals/votes.to_f
  end


end

