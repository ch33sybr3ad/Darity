class User < ActiveRecord::Base

  has_many :relationships
  has_many :pledged_dares, through: :relationships, class_name: "Dare"

  # has_many :challenged_dares, foreign_key: :daree_id, class_name: "Dare"
  # has_many :proposed_dares, foreign_key: :proposer_id, class_name: "Dare"

end
