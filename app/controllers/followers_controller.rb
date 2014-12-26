class FollowersController < ApplicationController
  before_action :authenticate_user!

  def fetch_followers
  end
end
