# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  avatar                 :string
#  twitter_username       :string
#  name                   :string
#  created_at             :datetime
#  updated_at             :datetime
#  slug                   :string
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
  has_one  :social_profile

  before_create :prepare_social_profile

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
      user = User.create_from_social_auth(auth)
      #Associate the identity with the user if needed
      user = Authentication.associate_with_social_auth(auth, user)
      user.update_social_profile(auth)
    else
      #Associate the identity with the user if needed
      user = Authentication.associate_with_social_auth(auth, user)
     user.update_social_profile(auth)
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.create_from_social_auth(auth)
      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        location = auth.info.location
        user_location = Geocoder.coordinates("#{location}")
        user = User.new(
          address: location,
          avatar: auth.info.image,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          latitude: user_location.first,
          longitude: user_location.second,
          password: Devise.friendly_token[0,20],
          name: auth.info.name,
          twitter_username: auth.info.nickname
        )
        #user.skip_confirmation!
        user.save!
      end
      user
  end

  def self.set_twitter_username(auth, user)
    if auth.provider == "twitter"
      user.twitter_username = auth.info.nickname
      user.save!
    end
  end

  def update_social_profile(auth)
    if auth.provider == "twitter"
      self.social_profile.update_attributes(twitter_followers: auth.extra.raw_info.followers_count)
    end
  end


  def username
    self.twitter_username
  end

  def get_authentication(name)
    authentications.where(provider: name).first
  end

  private

  def prepare_social_profile
    build_social_profile unless social_profile
  end
end
