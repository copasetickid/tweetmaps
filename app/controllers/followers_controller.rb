class FollowersController < ApplicationController
  before_action :authenticate_user!

  def fetch_followers
    current_user_access_token = current_user.latest_auth.access_token
    current_user_access_token_secret = current_user.latest_auth.access_token_secret
    @followers = Twitter::FollowerLookup.new(current_user_access_token, current_user_access_token_secret).collect_some_followers

    @followers.each do |follower|
      Follower.get_follower_data(follower, current_user.id)
    end
  end
end
