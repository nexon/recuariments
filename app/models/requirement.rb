class Requirement < ActiveRecord::Base
  belongs_to :project
  
  has_many   :requirement_attributes, class_name:"RequirementFieldValues", dependent: :destroy
  
  
  
  def build_attributes_with_values(attr)
    attr.each do |key,value|
      field = self.project.fields.find_by_field_name(key)
      unless field.blank?
        self.requirement_attributes.build(requirement_field: field, value:value)
      else
      end
    end
  end
  
  def serializable_attributes
    hash = {}
    self.requirement_attributes.each do |r|
      hash[r.field_name] = r.value
    end#.map {|a| a.serializable_hash}
    hash
  end
  
  def update_requirement_attributes(attr)
    attr.each do |key,value|
      field = self.project.fields.find_by_field_name(key)
      logger.debug field.inspect
      unless field.blank?
        # we need catch an error here?
        self.requirement_attributes.find_or_create_by(requirement_field_id: field.id).update_attributes(value: value)
      else
      end
    end
  end
end
