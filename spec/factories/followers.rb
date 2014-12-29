# == Schema Information
#
# Table name: followers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  username   :string(255)
#  location   :string(255)
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
