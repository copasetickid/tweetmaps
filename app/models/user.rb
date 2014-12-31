# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  avatar                 :string(255)
#  twitter_username       :string(255)
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  slug                   :string(255)
#

class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
  		  :rememberable, :trackable, :validatable, :omniauthable,
  		  omniauth_providers: [:twitter]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :followers
  has_many :authentications

  def self.find_from_twitter_auth(auth)
  	user = User.where(twitter_username: auth.info.nickname).first
  end

  def self.create_from_twitter_auth(auth)
    user = create do |user|
      user.twitter_username = auth.info.nickname
      user.avatar = auth.info.image
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
    user.save(validate: false)
    user
  end

  def self.find_for_omniauth(auth, signed_in_resource = nil)
    # Get the authentication and user if they exist
    social_auth =  Authentication.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : social_auth.user


    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          avatar: auth.info.image,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          name: auth.info.name,
          twitter_username: auth.info.nickname
        )
        #user.skip_confirmation!
        user.save!
      end
    end

    #Associate the identity with the user if needed
    if social_auth.user != user
      social_auth.user = user
      social_auth.access_token = auth.credentials.token
      social_auth.access_token_secret = auth.credentials.secret
      social_auth.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.set_twitter_username(auth, user)
    if auth.provider == "twitter"
      user.twitter_username = auth.info.nickname
      user.save!
    end
  end

  def username
    self.twitter_username
  end
end
