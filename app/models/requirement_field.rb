class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = {"text_field" => "string", "check_box" => "boolean"}
  
  before_validation :parameterize_name
  validates_uniqueness_of :field_name, scope: [:project_id]

  def parameterize_name
    self.field_name = self.name.parameterize.gsub("-","_")
  end
end
