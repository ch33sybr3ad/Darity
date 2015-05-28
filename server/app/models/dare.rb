class Dare < ActiveRecord::Base

  belongs_to :proposer, foreign_key: :proposer_id, class_name: "User"
  belongs_to :daree, foreign_key: :daree_id, class_name: "User"

  has_many :relationships
  has_many :pledgers, through: :relationships, class_name: "User"

end
