class PendingDare < ActiveRecord::Base
  belongs_to :proposer, foreign_key: :proposer_id, class_name: "User"
end
