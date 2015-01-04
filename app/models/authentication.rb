# == Schema Information
#
# Table name: authentications
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  provider            :string(255)
#  uid                 :string(255)
#  access_token        :string(255)
#  access_token_secret :string(255)
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
end