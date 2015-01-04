class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  include UserConcern

  def homepage
    if user_signed_in?
      redirect_to dashboard_path(current_user)
    end
  end

  def dashboard
    @user = User.friendly.find(params[:id])
      if @user != current_user
        render status: :not_found
      end
    rescue ActiveRecord::RecordNotFound
      render status: :not_found
  end
end
