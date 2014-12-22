require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, :type => :controller do

  context "user authentication via Twitter" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter_auth]
    end

    describe "when an existing user returns", :vcr do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "redirects to the root page" do
        get :twitter
        expect(response).to redirect_to root_path
      end
    end

    describe "when a user does not exist", :vcr do
      it "creates the user in the User table " do
        expect { get :twitter }.to change { User.count }.by +1
      end
    end
  end

end
