class Dare < ActiveRecord::Base

  has_many :relationships, foreign_key: "pledged_dare_id"
  has_many :pledgers, through: :relationships, source: :user

  belongs_to :proposer, foreign_key: :proposer_id, class_name: "User"
  belongs_to :daree, foreign_key: :daree_id, class_name: "User"

end
