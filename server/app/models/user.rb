class User < ActiveRecord::Base

  has_many :relationships
  has_many :dares, through: :relationships, foreign_key: :pledger_id

  has_many :dares, foreign_key: :daree_id, class_name: "User"
  has_many :dares, foreign_key: :proposer_id, class_name: "User"

end
