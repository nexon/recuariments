class RequirementAttributesController < ApplicationController
  
  def destroy
    @project = current_user.projects.find(params[:project_id])
    @attribute = @project.fields.find(params[:id])
    
    if @attribute.destroy && RequirementFieldValues.destroy(RequirementFieldValues.where(requirement_field_id: @attribute.id).ids)
      redirect_to project_path(@project), notice: "Successfully remove field."
    else
      redirect_to project_path(@project), alert: "Something went wrong."
    end
  end
end
