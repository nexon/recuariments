class Message < ActiveRecord::Base
  belongs_to :project
  
  before_save :posted_by
  
  
  private
  
  def posted_by
    self.post_by = current_user.email
  end
end
