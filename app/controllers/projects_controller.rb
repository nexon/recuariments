class ProjectsController < ApplicationController
  
  def index
    @projects = current_user.projects
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = current_user.projects.build(project_params)
    if @project.valid? && @project.save 
      redirect_to projects_path, notice: "Project Created successfully."
    else
      render :new
    end
  end
  
  def show
    begin
      @project     = current_user.projects.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      @requirements = @project.requirements
      @fields       = @project.fields      
    end

  end
  
  def edit
    begin
      @project = current_user.projects.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, aler: "Project not found."
    end
  end
  
  
  def update
    @project = current_user.projects.find(params[:id])
    
    if @project.update_attributes(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      render :edit
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
  
  def update_order
    project = current_user.projects.find(params[:id])
    old_position   = project.fields.find_by_field_name(params[:field])
    
    old_position.update(order: params[:order])
    
    result = {}
    
    if old_position.save
      result[:success] = true
      result[:message] = "Order updated!."
    else
      result[:success] = false
      result[:message] = "Order updated failed!."
    end
    respond_to do |format|
      format.json { render json: result}
    end
  end
  
  private
  
  def project_params
    params.require(:project).permit(:title, fields_attributes: [:id, :_destroy, :name, :field_type, :required])
  end
end
