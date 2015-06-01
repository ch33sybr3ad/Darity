class Video < ActiveRecord::Base
  belongs_to :dare
  has_many :comments

  validates_presence_of :url, :dare_id
end
