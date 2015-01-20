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

FactoryGirl.define do
  factory :user do
    name { OmniAuth.config.mock_auth[:twitter_auth].info.name }
    twitter_username { OmniAuth.config.mock_auth[:twitter_auth].info.nickname }
    sequence(:email) {|n| "person-#{n}@example.com" }
    password "password"
    avatar { OmniAuth.config.mock_auth[:twitter_auth].info.image }

    factory :user_with_twitter_auth do
        name { OmniAuth.config.mock_auth[:twitter_auth_female].info.name }
        twitter_username { OmniAuth.config.mock_auth[:twitter_auth_female].info.nickname }
    	after(:create) do |user, evaluator|
    		create(:authentication_with_twitter, user: user)
    	end
    end
  end
end
