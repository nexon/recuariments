class CollaboratorsController < ApplicationController
  
  def index
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      @collaborators = @project.memberships
    end 
  end
  
  def new
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      @collaborator = @project.users.build
    end
  end
  
  def create
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      begin
        @user         = User.find_by_email(params[:collaborator][:email])
      rescue ActiveRecord::RecordNotFound
        render :new
      else
        begin
          @collaborator = @project.users << @user
        rescue ActiveRecord::RecordInvalid
          render :new
        else  
          redirect_to project_path(@project), notice: "Collaborator Successfully added to project!."
        end
      end
    end
  end
  
  
  private
  
  def collaborator_params
    params.require(:collaborator).permit(:email)
  end
end
