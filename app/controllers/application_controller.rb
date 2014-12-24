class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'application'

  #Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource)
    dashboard_path(resource)
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
