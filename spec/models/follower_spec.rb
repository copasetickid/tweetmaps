# == Schema Information
#
# Table name: followers
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  location   :string
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Follower, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
