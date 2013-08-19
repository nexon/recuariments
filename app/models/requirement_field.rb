class RequirementField < ActiveRecord::Base
  belongs_to :project
  
  SUPPORTED_FIELD_TYPE = %w(text_field check_box textarea date)
  
  before_validation :parameterize_name
  validates :field_type, :name, presence: true
  validates :field_name, uniqueness: {scope: [:project_id]}
  validates :field_type, inclusion: { in:SUPPORTED_FIELD_TYPE}
  
  after_validation :copy_attribute_error
  before_save      :ordering_record
  
  default_scope { order(order: :asc) }
  
  after_destroy :ensure_remove_association
  private
  
  def copy_attribute_error
    # Since we don't have any field in the form that shows the field_name property
    # (because this property or attribute is calculated or generated before save the record)
    # the error don't will appear. So instead we ask if 
    # exist an error for field_name, and if exist, simple we add a new error for 
    # 'name' attribute with the value of the error 'field_name'. This approach will show 
    # the error in the form.
    
    if self.errors.has_key?(:field_name)
      self.errors.add(:name, self.errors.full_messages_for(:field_name).join(","))
    end
  end
  
  def parameterize_name
    self.field_name = self.name.parameterize.gsub("-","_")
  end
  
  def ordering_record
    # We obtain the last record order and  +1
    lastest_new_record = self.class.order("created_at").last
    self.order  =  lastest_new_record.blank? ? 1 : lastest_new_record.order + 1
  end
  
  def ensure_remove_association
    if self.project.fields.blank?
      self.project.requirements.destroy_all
    end 
  end
  
end
