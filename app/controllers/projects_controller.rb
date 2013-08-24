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
      @collaborators = @project.memberships
      @message      = @project.messages.build
      @messages     = @project.messages
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
    begin
      @project = current_user.projects.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, aler: "Project not found."
    else
      if @project.update_attributes(project_params)
       redirect_to projects_path, notice: "Project was successfully updated."
      else
        render :edit
      end
    end
  end
  
  def destroy
    begin
      @project = current_user.projects.find(params[:id])      
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, aler: "Project not found."
    else
      begin
        current_user_is_owner = current_user.memberships.find_by_project_id(@project)
      rescue ActiveRecord::RecordNotFound
        redirect_to projects_path, alert: "Something went wrong."
      else
        if current_user_is_owner.owner
          if @project.destroy
            redirect_to projects_path, notice: "Project #{@project.title} was successfully removed."
          else
            redirect_to projects_path, alert: "Something went wrong."
          end
        else
          redirect_to projects_path, alert: "You can't do that!."
        end
      end
    end
  end
  
  def update_order
    begin
      project = current_user.projects.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to project_requirement_fields_path, alert: "Project not found."
    else
      begin
        field_to_move  = project.fields.find_by_field_name(params[:field])
        old_position_field  = project.fields.find_by_order(params[:order])
      rescue ActiveRecord::RecordNotFound
        redirect_to project_requirement_fields_path, alert: "Something went wrong."
      else
        old_position_field.order = field_to_move.order
        field_to_move.order      = params[:order]
        result = {}
        if old_position_field.valid? && field_to_move.valid? && old_position_field.save && field_to_move.save
          result = {success: true, message: "Order of attributes successfully updated!."}
        else
          result = {success: false, message: "Something went wrong."}
        end
        respond_to do |format|
          format.json { render json: result}
        end
      end
    end
  end
  
  private
  
  def project_params
    params.require(:project).permit(:title, fields_attributes: [:id, :_destroy, :name, :field_type, :required])
  end
end
