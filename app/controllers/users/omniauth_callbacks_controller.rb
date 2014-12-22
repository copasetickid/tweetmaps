class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
  	@user = User.find_from_twitter_auth(auth)

  	if @user
  		return sign_in_and_redirect @user, :event => :authentication
  	end

  	@user = User.create_from_twitter_auth(auth)
  	
  	if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    elses
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end