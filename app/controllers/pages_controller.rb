class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def homepage
    if user_signed_in?
      redirect_to dashboard_path(current_user)
    end
  end

  def dashboard
    @user = User.friendly.find(params[:id])
  end
end
