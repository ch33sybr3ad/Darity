class Relationship < ActiveRecord::Base

  belongs_to :pledger, foreign_key: "pledger_id", class_name: "User"
  belongs_to :dare

end
