class RegistrationMailer < ActionMailer::Base
  default from: "Collaborator <nobody@recuariments.us>"
  
  def new_user_with_invitation_email(email, password)
    @email = email
    @signin  = 'http://recuariments.us/login'
    @signup  = 'http://recuariments.us/sign_up'
    @password = password
    mail(to: @email, subject: 'You have been Invited!')
  end
end
