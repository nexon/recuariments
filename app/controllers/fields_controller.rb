class FieldsController < ApplicationController
  
  def new
    @project = current_user.projects.find(params[:project_id])
    @requirement_attribute = @project.fields.build
  end
  
  def create
    @project = current_user.projects.find(params[:project_id])
    @requirement_attribute   = @project.fields.build(fields_params)
    
    if @requirement_attribute.valid? && @requirement_attribute.save
      redirect_to project_path(@project), notice: "Successfully added new field."
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    @project = current_user.projects.find(params[:project_id])
    @field = @project.fields.find(params[:id])
    
    if @field.destroy && RequirementFieldValues.destroy(RequirementFieldValues.where(requirement_field_id: @field.id).ids)
      redirect_to project_path(@project), notice: "Successfully remove field."
    else
      redirect_to project_path(@project), alert: "Something went wrong."
    end
  end
  
  private
  
  def fields_params
    params.require(:requirement_field).permit(:field_type, :name, :required)
  end
end
