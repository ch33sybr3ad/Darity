class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :comment

  validates_presence_of :comment_id, :user_id
  validates_uniqueness_of :comment_id, scope: :user_id
  validates :value, 
            allow_nil: true, 
            numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1, other_than: 0 }
end
