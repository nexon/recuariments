class Project < ActiveRecord::Base
  belongs_to :user
  has_many   :requirements, dependent: :destroy
  has_many   :fields, class_name: "RequirementField", dependent: :destroy
  validates_associated :fields
  
  accepts_nested_attributes_for :fields, allow_destroy: true
end
