class User < ActiveRecord::Base

  has_many :relationships, foreign_key: "pledger_id"
  has_many :pledged_dares, through: :relationships, source: :dare, foreign_key: "pledged_dare_id"

  has_many :challenged_dares, foreign_key: :daree_id, class_name: "Dare"
  has_many :proposed_dares, foreign_key: :proposer_id, class_name: "Dare"

end
