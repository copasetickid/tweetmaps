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

require 'rails_helper'

RSpec.describe SocialProfile, :type => :model do
  it { should belong_to(:user) }
end
