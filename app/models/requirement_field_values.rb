class RequirementFieldValues < ActiveRecord::Base
  belongs_to :requirement
  belongs_to :requirement_field
  
  delegate   :field_type, :name, :field_name, to: :requirement_field
end
