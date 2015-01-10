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

require 'rails_helper'

RSpec.describe User, :type => :model do
  context "Social Authentication" do

    describe ".find_for_omniauth" do
      let(:auth) { OmniAuth.config.mock_auth[:twitter_auth] }

      it "returns a new user" do
        expect { User.find_for_omniauth(auth) }.to change { User.count }.by +1
      end

      context "Sign in via twitter" do
         it "sets information from twitter & auth credentials " do
          user = User.find_for_omniauth(auth)
          user_auth = user.authentications.first

          expect(user.twitter_username).to eq auth['info']['nickname']
          expect(user.name).to eq auth['info']['name']
          expect(user.avatar).to eq auth['info']['image']

          expect(user_auth.provider).to eq "twitter"
          expect(user_auth.uid).to eq auth['uid']
          expect(user_auth.access_token).to eq auth['credentials']['token']
          expect(user_auth.access_token_secret).to eq auth['credentials']['secret']
        end
      end
    end
  end

  describe ".username" do
    it "generates a slug based on the user's twitter name" do
      user = create(:user)
      expect(user.slug).to eq user.twitter_username
    end
  end
end
