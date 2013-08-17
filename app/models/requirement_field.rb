class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = {"text_field" => "string", "check_box" => "boolean"}
  
  before_save :parameterize_name
  
  #validates  :field_name, uniqueness: {conditions: -> { where("fields.field_name != ?", self.field_name) }} scope: :project#conditions:  #scope: [:project_id]
  # validates_with UniquenessFieldName
    
  validates_each :field_name do |record, attr, value|
    logger.debug record.project.fields.find_by_field_name(record.name.parameterize.gsub("-","_")).inspect
    unless record.project.fields.find_by_field_name(value).blank?
      record.errors.add(value, "cannot be repeated.")
    end
  end
  
  # def uniqueness_field_name
  #   errors.add(:base, "cannot be repeated.") unless self.project.fields.find_by_field_name(self.field_name).blank?
  # end
  def parameterize_name
    self.field_name = self.name.parameterize.gsub("-","_")
  end
end
