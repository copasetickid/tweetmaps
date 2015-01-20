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

  def self.get_follower_data(follower, user_id)
    Follower.where(username: follower.screen_name, user_id: user_id).first_or_create!
  end
end
