class Twitter::FollowerLookup

  def initialize(user_token=nil, user_token_secret=nil )
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_key
      config.consumer_secret     = Rails.application.secrets.twitter_secret
      config.access_token        = user_token
      config.access_token_secret = user_token_secret
    end
  end

  def collect_some_followers
    @client.followers.take(50)
  end
end
