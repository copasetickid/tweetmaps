require 'rails_helper'

RSpec.describe FollowersController, :type => :controller  do
  let! (:user) { create(:user) }

  describe "GET fetch_followers", :wip => true do
    pending
    before do
      sign_in user
    end

    it "returns http success" do
      get :fetch_followers
      expect(response).to have_http_status(:success)
    end

    it "collects 50 of the user's followers" do
      current_user_access_token = user.access_token
      current_user_access_token_secret = user.access_token_secret
      VCR.use_cassette("twitter/follower_lookup") do
        Twitter::FollowerLookup.new(current_user_access_token, current_user_access_token_secret).collect_some_followers
      end
      get :fetch_followers
      expect(assigns(:followers).length).to eq 50
    end
  end
end
