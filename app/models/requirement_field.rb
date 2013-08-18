class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = %w(text_field check_box textarea)
  
  before_validation :parameterize_name
  validates :field_type, :name, presence: true
  validates :field_name, uniqueness: {scope: [:project_id]}
  validates :field_type, inclusion: { in:SUPPORTED_FIELD_TYPE}
  
  private
  
  def parameterize_name
    self.field_name = self.name.parameterize.gsub("-","_")
  end
end
