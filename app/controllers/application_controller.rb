class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'application'

  #Catch the CanCan Expection
  rescue_from CanCan::AccessDenied do |exception|
    render status: :not_found
  end

  #Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource)
    if resource.email_verified?
      dashboard_path(resource)
    else
      finish_signup_path(resource)
    end
  end

  #Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource)
    root_path
  end

  #Overriding devise method :authenticate_user!
  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
