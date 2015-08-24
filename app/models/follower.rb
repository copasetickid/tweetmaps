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

class Follower < ActiveRecord::Base
  belongs_to :user
  geocoded_by :location

  def self.get_follower_data(follower, user_id)
    location = follower.location
    location_value = Geocoder.coordinates("#{location}")
    if location_value.present?
      Follower.where(username: follower.screen_name, user_id: user_id,
        location: follower.location, latitude: location_value.first,
        longitude: location_value.second
        ).first_or_create!
    end
  end
end
