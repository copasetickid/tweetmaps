# == Schema Information
#
# Table name: authentications
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  provider            :string
#  uid                 :string
#  access_token        :string
#  access_token_secret :string
#  created_at          :datetime
#  updated_at          :datetime
#

class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    Authentication.where(uid: auth.uid, provider: auth.provider).first_or_create
  end

  #Associate the identity with the user if needed
  def self.associate_with_social_auth(auth, user)
    social_auth  = Authentication.where(uid: auth.uid, provider: auth.provider).first

    if social_auth.user != user
      social_auth.user = user
      social_auth.access_token = auth.credentials.token
      social_auth.access_token_secret = auth.credentials.secret
      social_auth.save!
    end

    user
  end
end
