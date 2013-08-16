class ProjectsController < ApplicationController
  
  def index
    
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = current_user.projects.build(project_params)
    
    if @project.valid? && @project.save
      redirect_to projects_path, notice: "Project Created successfully."
    else
      render :new, alert: "Something went wrong."
    end
  end
  
  def show
    @project     = current_user.projects.find(params[:id])
    @requirement = []
    @requirement_attributes = []
  end
  
  def edit
    @project = current_user.projects.find(params[:id])
  end
  
  
  def update
    @project = current_user.projects.find(params[:id])
    
    if @project.update_attributes(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      redirect_to edit_project_path(@project), alert: "Something went wrong."
    end
  end
  
  def destroy
    @project = current_user.projects.find(params[:id])
    
    if @project.destroy
      redirect_to projects_path, notice: "Project #{@project.title} was successfully removed."
    else
      redirect_to projects_path, alert: "Something went wrong."
    end
  end
  
  private
  
  def project_params
    params.require(:project).permit(:title, fields_attributes: [:id, :_destroy, :name, :field_type, :required])
  end
end
