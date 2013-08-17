class RequirementFieldValues < ActiveRecord::Base
  belongs_to :requirement
  belongs_to :requirement_field
  
  validates_presence_of  :value, if: -> (field_value) {field_value.requirement_field.required == true}
  
  delegate   :field_type, :name, :field_name, to: :requirement_field
end
