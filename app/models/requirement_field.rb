class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = {"text_field" => "string", "check_box" => "boolean"}
  
  before_validation :parameterize_name
  
  
  #validates  :field_name, uniqueness: {conditions: -> { where("fields.field_name != ?", self.field_name) }} scope: :project#conditions:  #scope: [:project_id]
  # validates_with UniquenessFieldName
    
  # validates_each :field_name do |record, attr, value|
  #   if not record.new_record?
  #     unless record.project.fields.find_by_field_name(record.name.parameterize.gsub("-","_")).blank?
  #       record.errors.add(value, "cannot be repeated.")
  #     end
  #   end
  # end
  validates_uniqueness_of :field_name, scope: [:project_id]

  def parameterize_name
    self.field_name = self.name.parameterize.gsub("-","_")
  end
end
