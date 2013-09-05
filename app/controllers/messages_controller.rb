class MessagesController < ApplicationController
  def index
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
       redirect_to projects_path, alert: "Project not found."
    else
      @message  = Message.new
      @messages = @project.messages
    end
    
  end  
  def create
    begin
      @project = current_user.projects.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to projects_path, alert: "Project not found."
    else
      @message = @project.messages.build(message_params)
      # I really don't know any better place to put this.
      @message[:post_by] = current_user.email
      if @message.valid? && @message.save
        redirect_to project_messages_path(@project), notice: "Message Successfully posted!."
      else
        render :show
      end
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:body)
  end
end
