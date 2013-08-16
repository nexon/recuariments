class RequirementsController < ApplicationController
  
  def new 
    @project = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.build
    @fields      = @project.fields
  end
  
  def create
    
  end
end
