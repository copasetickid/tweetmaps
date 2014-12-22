class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
  		  :rememberable, :trackable, :validatable, :omniauthable,
  		  omniauth_providers: [:twitter]

  def self.find_from_twitter_auth(auth)
  	user = User.where(twitter_username: auth.info.nickname).first
  end

  def self.create_from_twitter_auth(auth)
    user = create do |user|
      user.twitter_username = auth.info.nickname
      user.uid = auth.uid
      user.avatar = auth.info.image
      user.provider = auth.provider
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
    user.save(validate: false)
    user
  end
end
