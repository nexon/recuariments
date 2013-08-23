class RequirementsController < ApplicationController
  def index
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      @requirements = @project.requirements
    end
  end
  def new 
    @project = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.build
    @fields      = @project.fields
  end
  
  def create
    @project  = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.build

    @requirement.build_attributes_with_values(requirement_params)
    
    if @requirement.valid? && @requirement.save
      redirect_to project_path(@project), notice: "Requirement Successfully added to the project."
    else
      @fields = @project.fields      
      render :new
    end
  end
  
  def edit
    @project = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
    @fields      = @project.fields
  end
  
  def update
    @project = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
    
    if @requirement.update_requirement_attributes(requirement_params)
      redirect_to project_path(@project), notice: "Requirement Successfully updated."
    else
      @fields      = @project.fields
      render :edit
    end
  end
  
  def show
    @project = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
  end
  
  def destroy
    @project = current_user.projects.find(params[:project_id])
    @requirement = @project.requirements.find(params[:id])
    
    if @requirement.destroy
      redirect_to project_path(@project), notice: "Requirement Successfully removed."
    else
      redirect_to project_path(@project), alert: "Something went wrong."
    end
  end
  
  def export_pdf
    project = current_user.projects.find(params[:project_id])
    requirements = project.requirements
    if(requirements.empty?)
      redirect_to project_path(project), alert: "You don't have any requirement to export."
    else
      output = RequirementReport.new.to_pdf(requirements)
      send_data output, :filename => "#{project.title.parameterize.gsub('-','_')}_requirements_#{Time.now.to_i}", 
                        :type => "application/pdf"
    end
  end
  
  private
  
  def requirement_params
    params.require(:requirement).permit!
  end
end
