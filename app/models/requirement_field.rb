class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = {"text_field" => "string", "check_box" => "boolean"}
  
  validates_each :name do |record, attr, value|
    unless record.project.fields.find_by_name(value).blank?
      record.errors.add(value, "cannot be repeated.")
    end
  end
end
