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

class SocialProfile < ActiveRecord::Base
  belongs_to :user
end
