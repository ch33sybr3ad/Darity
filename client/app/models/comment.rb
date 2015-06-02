class Comment < ActiveRecord::Base

  belongs_to :dare

  has_many :likes
  has_many :users, through: :likes

end
