class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,#,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

        has_many :memberships
        has_many :projects, through: :memberships
         
         # has_many :projects, dependent: :destroy
         
   def self.create_user(email)
     generated_password = Devise.friendly_token.first(8)
     # RegistrationMailer.welcome(user, generated_password).deliver
     user = User.create!(email: email, password: generated_password)
   end
end
