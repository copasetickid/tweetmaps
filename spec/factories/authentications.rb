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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider "twitter"
    uid { OmniAuth.config.mock_auth[:twitter_auth].uid }
    access_token { OmniAuth.config.mock_auth[:twitter_auth].credentials.token }
    access_token_secret { OmniAuth.config.mock_auth[:twitter_auth].credentials.secret }

    factory :authentication_with_twitter do
      provider "twitter"
      uid { OmniAuth.config.mock_auth[:twitter_auth_female].uid }
      access_token { OmniAuth.config.mock_auth[:twitter_auth_female].credentials.token }
      access_token_secret { OmniAuth.config.mock_auth[:twitter_auth_female].credentials.secret }
    end
  end
end

