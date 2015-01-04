# == Schema Information
#
# Table name: authentications
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  provider            :string(255)
#  uid                 :string(255)
#  access_token        :string(255)
#  access_token_secret :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

require 'rails_helper'

RSpec.describe Authentication, :type => :model do

  before(:each) do
    @user = build_stubbed(:user)
    @authentication = @user.authentications.build
  end

  it "validates uniqueness of social media account credentials so that only one user can have a given social auth" do
    user1 = create(:user, email: "lorde@test.com")
    user2 = create(:user, email: "britney@test.com")
    auth1 = build(:authentication, provider: "twitter", uid: "12348", user: user1)
    auth2 = build(:authentication, provider: "twitter", uid: "12348", user: user2)
    auth1.save
    expect(auth2).not_to be_valid
    auth3 = build(:authentication, provider: "facebook", uid: "12348", user: user2)
    expect(auth3).to be_valid
  end
end
