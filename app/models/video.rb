class Video < ActiveRecord::Base
  belongs_to :dare

  validates_presence_of :url, :dare_id
end
