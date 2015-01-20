class FollowersController < ApplicationController
  before_action :authenticate_user!

  def fetch_followers
  	twiiter_auth = current_user.get_authentication("twitter")
    access_token = twiiter_auth.access_token
    access_token_secret = twitter_auth.access_token_secret
    @followers = Twitter::FollowerLookup.new(access_token, access_token_secret).collect_some_followers

    @followers.each do |follower|
      Follower.get_follower_data(follower, current_user.id)
    end
  end
end
