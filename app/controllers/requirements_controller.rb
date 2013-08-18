class RequirementsController < ApplicationController
  
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
  
  def export_pdf
    output = RequirementReport.new.to_pdf
    send_data output, :filename => "hello.pdf", 
                      :type => "application/pdf"
  end
  
  private
  
  def requirement_params
    params.require(:requirement).permit!
  end
end
