class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  # after_initialize :set_two_way

  # def set_two_way
  #   if !follower_id

  # end

  # validates :follower, presence: true
  # validates :followee, presence: true
  # validates_uniqueness_of :follower, scope: :followee
end
