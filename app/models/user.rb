class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,#,:confirmable,
       :recoverable, :rememberable, :trackable, :validatable
       
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  def self.create_user(email)
   generated_password = Devise.friendly_token.first(8)
   RegistrationMailer.new_user_with_invitation_email(email,generated_password).deliver
   user = User.create!(email: email, password: generated_password)
  end
end
