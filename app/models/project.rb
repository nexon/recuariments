class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
  has_many :memberships
  has_many :members, class_name: "User", through: :membership

  # belongs_to :owner, class_name: "User"

  has_many   :requirements, dependent: :destroy
  has_many   :fields, class_name: "RequirementField", dependent: :destroy
    
  accepts_nested_attributes_for :fields, allow_destroy: true
  validates_uniqueness_of :title, scope:[:user_id]
  validates_presence_of   :title
  
  
end
