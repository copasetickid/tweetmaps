# == Schema Information
#
# Table name: followers
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  location   :string
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :follower do
    
  end

end
