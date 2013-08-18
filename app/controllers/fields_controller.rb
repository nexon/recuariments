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
      # Since we don't have any field in the form that shows the field_name property
      # (because this property or attribute is calculated or generated before save the record)
      # the error don't will appear. So instead we ask if 
      # exist an error for field_name, and if exist, simple we add a new error for 
      # 'name' attribute with the value of the error 'field_name'. This approach will show 
      # the error in the form.
      
      if @requirement_attribute.errors.has_key?(:field_name)
        @requirement_attribute.errors.add(:name, @requirement_attribute.errors.full_messages_for(:field_name).join(","))
      end
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
