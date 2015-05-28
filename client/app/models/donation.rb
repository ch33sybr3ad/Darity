class Donation < ActiveRecord::Base
  belongs_to :user, foreign_key: "pledger_id"
  belongs_to :dare, foreign_key: "pledged_dare_id"
end
