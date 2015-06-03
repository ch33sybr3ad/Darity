class Charity < ActiveRecord::Base
  has_many :dares

  validates_presence_of :name, :url, :mission, :transparency_score
  validates_uniqueness_of :name, :url, :mission, :transparency_score
end
