require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  let! (:user) { create(:user) }

  describe "GET homepage" do
    it "renders when a user isn't signed in" do
      get :homepage
      expect(response).to have_http_status(:success)
    end

    context "user is signed in" do
      before do
        sign_in user
      end
      it "redirects to their dashboard" do
        get :homepage
        expect(response).to redirect_to dashboard_path(user)
      end
    end
  end

  describe "GET dashboard" do
    before do
      sign_in user
    end

    it "returns http success" do
      get :dashboard, id: user
      expect(response).to have_http_status(:success)
    end

    it "assigns the user " do
      get :dashboard, id: user
      expect(assigns(:user)).to eq user
    end

    context "rendering another user's dashboard" do
      let! (:pharrell) { create(:user, twitter_username: "pharrell") }

      it "renders the 404 page" do
        get :dashboard, id: pharrell
        expect(response).to have_http_status(404)
      end
    end
  end
end
