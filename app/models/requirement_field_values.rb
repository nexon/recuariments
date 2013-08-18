class RequirementFieldValues < ActiveRecord::Base
  belongs_to :requirement
  belongs_to :requirement_field
  
  validates_presence_of  :value, if: -> (field_value) {field_value.requirement_field.required == true}
  validates_uniqueness_of :value, scope: [:requirement_field_id], if: ->(field_value) { field_value.requirement_field.unique == true}, message: "has already been taken"
  
  delegate   :field_type, :name, :field_name, to: :requirement_field
  # after_validation :append_nested_errors
#   
#   def append_nested_errors
#     if self.errors.has_key?(:value)
#       self.requirement.errors.add(self.requirement_field.field_name, self.errors.full_messages_for(:value).join(","))
#     end
#   end
  
end
