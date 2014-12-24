Given(/^I am logged in via my twitter account$/) do
  @user = create(:user)
  login_as(@user, :scope => :user)
end

Given(/^I am on my dashboard$/) do
  visit dashboard_path(@user)
end

Then(/^I should see my basic information$/) do
  expect(page).to have_content "Welcome!!"
end
