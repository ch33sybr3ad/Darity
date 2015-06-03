class Comment < ActiveRecord::Base

  belongs_to :dare

  has_one :author, class_name: "User", foreign_key: "id"

  has_many :likes
  has_many :users, through: :likes

  validates_presence_of :body, :author_id, :dare_id

end
