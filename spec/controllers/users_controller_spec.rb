require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET finish_signup" do

    context "user doesn't have a valid email" do
      let(:user) { create(:user, email: "change@me-twitter.com") }

      before do
        sign_in user
      end

      it "returns http success" do
        get :finish_signup, id: user
        expect(response).to have_http_status(:success)
      end
    end

    context "user has a valid email" do
      let(:valid_user) { create(:user) }

      before do
        sign_in valid_user
      end

      it "redirects to their dashboard" do
        get :finish_signup, id: valid_user
        expect(response).to redirect_to dashboard_path(valid_user)
      end
    end
  end

  describe "UPDATE finish_signup" do

    context "user doesn't have a valid email" do
      let(:user) { create(:user, email: "change@me-twitter.com") }

      before do
        sign_in user
      end

      it "sets the new email address" do
        patch :finish_signup, id: user, user: { email: "hello@lordemusic.com" }
        user.reload
        expect(assigns(:user).email).to eq "hello@lordemusic.com"
      end

      it "redirects to the dashboard" do
        patch :finish_signup, id: user, user: { email: "hello@lordemusic.com" }
        expect(response).to redirect_to dashboard_path(user)
      end
    end
  end
end
