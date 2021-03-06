class CollaboratorsController < ApplicationController
  
  def index
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      @collaborators = @project.memberships.where.not(user_id: current_user.id)
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
      @user  = User.find_by_email(params[:collaborator][:email])
      unless @user.blank?
        begin
          @collaborator = @project.users << @user
        rescue ActiveRecord::RecordInvalid
          render :new
        else  
          CollaboratorMailer.project_invitation_email(@user.email, @project.title).deliver
          redirect_to project_collaborators_path(@project), notice: "Collaborator Successfully added to project!."
        end
      else
        # the user don't exist so we create one
        @user = User.create_user(params[:collaborator][:email])
        @collaborator = @project.users << @user
        redirect_to project_collaborators_path(@project), notice: "Collaborator Successfully created and added to project!."
      end
    end
  end
  
  def destroy
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      begin
        @user = @project.memberships.find_by_user_id(params[:id])
        current_user_is_owner = current_user.memberships.find_by_project_id(@project)
      rescue ActiveRecord::RecordNotFound 
        redirect_to projects_path, alert: "Something went wrong."
      else
        if current_user_is_owner.owner
          if @user.destroy
            redirect_to project_collaborators_path(@project), notice: "Collaborator was successfully removed."
          else
            render :index
          end
        else
          redirect_to project_collaborators_path(@project), alert: "You can't do that!."
        end
      end
      
    end
  end
  
  
  private
  
  def collaborator_params
    params.require(:collaborator).permit(:email)
  end
end
