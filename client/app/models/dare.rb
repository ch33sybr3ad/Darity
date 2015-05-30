class Dare < ActiveRecord::Base
  has_many :donations, foreign_key: "pledged_dare_id"
  has_many :pledgers, through: :donations, source: :user
  has_one :video

  belongs_to :proposer, foreign_key: :proposer_id, class_name: "User"
  belongs_to :daree, foreign_key: :daree_id, class_name: "User"
  belongs_to :charity

  validates_presence_of :title, :description, :proposer_id, :daree_id

  validates :price, numericality: true

end
