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

FactoryGirl.define do
  factory :user do
    name { OmniAuth.config.mock_auth[:twitter_auth].name }
    twitter_username { OmniAuth.config.mock_auth[:twitter_auth].info.nickname }
    sequence(:email) {|n| "person-#{n}@example.com" }
    password "password"
    avatar { OmniAuth.config.mock_auth[:twitter_auth].info.image }
  end
end
