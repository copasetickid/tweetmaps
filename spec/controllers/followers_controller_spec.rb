require 'rails_helper'

RSpec.describe FollowersController, :type => :controller do
  let! (:user) { create(:user) }

  describe "GET fetch_followers" do
    before do
      sign_in user
    end

    it "returns http success" do
      get :fetch_followers
      expect(response).to have_http_status(:success)
    end
  end
end
