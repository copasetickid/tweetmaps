class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
  	@user = User.find_for_omniauth(auth, current_user)

  	if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
