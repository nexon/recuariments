class Membership < ActiveRecord::Base
  belongs_to :project, inverse_of: :memberships
  belongs_to :user, inverse_of: :memberships

  validates_uniqueness_of :project_id, scope: :user_id
end
