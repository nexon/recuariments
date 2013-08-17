class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = {"text_field" => "string", "check_box" => "boolean"}
  
  before_save :parameterize_name
  
  validates_each :field_name do |record, attr, value|
    unless record.project.fields.find_by_field_name(value).blank?
      record.errors.add(value, "cannot be repeated.")
    end
  end
  
  def parameterize_name
    self.field_name = self.name.parameterize.gsub("-","_")
  end
end
