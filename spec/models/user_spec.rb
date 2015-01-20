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

require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:followers) }
  it { should have_many(:authentications) }
  it { should have_one(:social_profile) }

  context "Social Authentication" do

    describe ".find_for_omniauth" do
      let(:auth) { OmniAuth.config.mock_auth[:twitter_auth] }

      it "returns a new user" do
        expect { User.find_for_omniauth(auth) }.to change { User.count }.by +1
      end

      context "Sign in via twitter" do
        let!(:user_with_auth) { create(:user_with_twitter_auth) }
        let!(:twitter_auth) { OmniAuth.config.mock_auth[:twitter_auth_female] }

         it "sets information from twitter & auth credentials " do
          user = User.find_for_omniauth(twitter_auth)
          user_auth = user.authentications.first

          expect(user.twitter_username).to eq twitter_auth['info']['nickname']
          expect(user.name).to eq twitter_auth['info']['name']
          expect(user.avatar).to eq twitter_auth['info']['image']

          expect(user_auth.provider).to eq "twitter"
          expect(user_auth.uid).to eq twitter_auth['uid']
          expect(user_auth.access_token).to eq twitter_auth['credentials']['token']
          expect(user_auth.access_token_secret).to eq twitter_auth['credentials']['secret']
          
          expect(user.social_profile.twitter_followers).to eq twitter_auth['extra']['raw_info']['followers_count']
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
