require 'feature_helper'

RSpec.describe "User Authentication", :type => :feature do

  context "when no type of user is signed in" do
    it "asks you sign in if you're not signed in" do
      visit root_path
      within ".twitter-login" do
        expect(page).to have_content "Sign in with Twitter"
      end
    end
  end

  context "signed in as a student" do
    let!(:user) { create(:user)}
    before do
      login_as(user, :scope => :user)
    end

    it "renders the log out link" do
      visit root_path
      expect(page).to have_link "Log Out", href: destroy_user_session_path
    end

    it "renders a welcome message" do
      visit root_path
      expect(page).to have_content "Welcome!!"
    end
  end
end
