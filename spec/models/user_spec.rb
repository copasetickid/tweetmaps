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

require 'rails_helper'

RSpec.describe User, :type => :model do
  context "Authentication" do
    describe ".find_from_twitter_auth" do
      let(:auth) { OmniAuth.config.mock_auth[:twitter_auth] }
      it "finds existings users" do
        create(:user)
        user = User.find_from_twitter_auth(auth)
        expect(user).to be_persisted
      end
    end

    describe ".create_from_twitter_auth" do
      let(:auth) { OmniAuth.config.mock_auth[:twitter_auth] }

      it "returns a new user" do
        expect { User.create_from_twitter_auth(auth) }.to change { User.count }.by +1
      end

      it "sets information from twitter " do
        user = User.create_from_twitter_auth(auth)
        expect(user.twitter_username).to eq auth['info']['nickname']
        expect(user.uid).to eq auth['uid']
        expect(user.name).to eq auth['info']['name']
        expect(user.provider).to eq "twitter"
        expect(user.avatar).to eq auth['info']['image']
        expect(user.access_token).to eq auth['credentials']['token']
        expect(user.access_token_secret).to eq auth['credentials']['secret']
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
