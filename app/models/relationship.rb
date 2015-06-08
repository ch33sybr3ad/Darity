class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  validates_presence_of :follower, :followee
  validates_uniqueness_of :follower, scope: :followee
end
