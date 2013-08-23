class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  layout :layout_selector
  
  private
  
  def layout_selector
    if devise_controller?
      "default_layout"
    else
      if (controller_name == "projects" && action_name != "index") || controller_list.include?(controller_name)
        "project_layout"
      else
        "application_layout"
      end
    end
  end
  
  def controller_list
    c = Dir[Rails.root.join('app/controllers/*_controller.rb')].map { |path| path.match(/(\w+)_controller.rb/); $1 }.compact
    c.delete("projects")
    c
  end
end
