require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  let! (:user) { create(:user) }
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
  end
end
