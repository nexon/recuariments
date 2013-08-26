module ApplicationHelper
  def is_active?(name)
    "active" if controller_name.eql?(name)
  end
end
