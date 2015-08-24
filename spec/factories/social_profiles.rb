# == Schema Information
#
# Table name: social_profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  twitter_followers :integer
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
  factory :social_profile do
  end
end
