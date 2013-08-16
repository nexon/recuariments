class Requirement < ActiveRecord::Base
  belongs_to :project
  
  has_many   :requirement_attributes, class_name:"RequirementFieldValue"
end
