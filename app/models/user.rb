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
#  provider               :string(255)
#  uid                    :string(255)
#  access_token           :string(255)
#  access_token_secret    :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  slug                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
  		  :rememberable, :trackable, :validatable, :omniauthable,
  		  omniauth_providers: [:twitter]

  extend FriendlyId
  friendly_id :username, use: :slugged

  def self.find_from_twitter_auth(auth)
  	user = User.where(twitter_username: auth.info.nickname).first
  end

  def self.create_from_twitter_auth(auth)
    user = create do |user|
      user.twitter_username = auth.info.nickname
      user.uid = auth.uid
      user.avatar = auth.info.image
      user.provider = auth.provider
      user.name = auth.info.name
      user.access_token = auth.credentials.token
      user.access_token_secret = auth.credentials.secret
      user.password = Devise.friendly_token[0, 20]
    end
    user.save(validate: false)
    user
  end

  def username
    self.twitter_username
  end
end
