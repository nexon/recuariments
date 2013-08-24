class Project < ActiveRecord::Base
  has_paper_trail
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
  has_many :memberships, inverse_of: :project
  has_many :users, through: :memberships

  # belongs_to :owner, class_name: "User"

  has_many   :requirements, dependent: :destroy
  has_many   :fields, class_name: "RequirementField", dependent: :destroy
    
  #accepts_nested_attributes_for :fields, allow_destroy: true
  validates_presence_of   :title

  after_create :make_owner

  def make_owner
  	self.memberships.last.update_attribute(:owner, true)
  end
end
