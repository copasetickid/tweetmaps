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
end
