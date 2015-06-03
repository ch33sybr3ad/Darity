class Comment < ActiveRecord::Base

  belongs_to :dare

  belongs_to :author, class_name: "User"

  has_many :likes
  has_many :users, through: :likes

  validates_presence_of :body, :author_id, :dare_id

end
