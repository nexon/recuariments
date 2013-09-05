class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
  has_many :memberships, inverse_of: :project, dependent: :destroy
  has_many :users, through: :memberships
  has_many :messages, dependent: :destroy
  
  # belongs_to :owner, class_name: "User"

  has_many   :requirements, dependent: :destroy
  has_many   :fields, class_name: "RequirementField", dependent: :destroy
    
  #accepts_nested_attributes_for :fields, allow_destroy: true
  validates_presence_of   :title
  has_paper_trail
  
  after_create :make_owner

  def make_owner
  	self.memberships.last.update_attribute(:owner, true)
  end
end
