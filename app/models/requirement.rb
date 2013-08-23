class Requirement < ActiveRecord::Base
  belongs_to :project
  
  has_many   :requirement_attributes, class_name:"RequirementFieldValues", dependent: :destroy
  
  validates_presence_of :requirement_attributes
  validates_associated  :requirement_attributes
  
  after_initialize :custom_getters_and_setters
  after_validation :append_nested_errors
  
  def build_attributes_with_values(attr)
    attr.each do |key, value|
      self.send("#{key}=", value)
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
      logger.debug("#{key} = #{value}")
      self.send("#{key}=", value)
    end
    logger.debug("inspect object: #{self.inspect}")
    (self.errors.empty?) ? true : false
  end
  
  def custom_getters_and_setters
    self.project.fields.each do |method_name|
      self.class.class_eval do
        define_method method_name.field_name do
          record = self.requirement_attributes.find_by_requirement_field_id(method_name.id)
          record ? record.value : nil
        end
        
        define_method "#{method_name.field_name}=" do |arg|
          record =self.requirement_attributes.find_by(requirement_field_id: method_name.id)
          if record.blank?
            self.requirement_attributes.build(requirement_field: method_name, value: arg).save
          else
            unless record.update(value: arg)
              self.errors.add(method_name.field_name, record.errors.full_messages_for(:value).join(","))
            end
          end
        end
      end
    end
  end
  
  def append_nested_errors
    self.requirement_attributes.each do |attribute|
      unless attribute.valid?
       logger.debug attribute.errors.inspect
       self.errors.add(attribute.field_name, attribute.errors.full_messages_for(:value).join(","))
     end
    end
  end
end
