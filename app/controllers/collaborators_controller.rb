class CollaboratorsController < ApplicationController
  def new
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to project_path(@project), alert: "Project not found."
    else
      @collaborator = @project.users.build
    end
  end
  
  def create
    if false
      "OLI"
    else
      render :new
    end
  end
end
