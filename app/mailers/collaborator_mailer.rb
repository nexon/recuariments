class CollaboratorMailer < ActionMailer::Base
  default from: "bot@recuariments.us"
  
  def project_invitation_email(email, project_name)
    @email = email
    @project_name = project_name
    @signin  = 'http://recuariments.us/login'
    @signup  = 'http://recuariments.us/sign_up'
    mail(to: @email, subject: 'You have been Invited!')
  end
end
