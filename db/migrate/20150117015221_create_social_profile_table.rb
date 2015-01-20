class CreateSocialProfileTable < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
    	t.integer :user_id
    	t.integer :twitter_followers
    	t.timestamps
    end
  end
end
