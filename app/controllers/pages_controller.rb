class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def homepage
  end

  def dashboard
    @user = User.friendly.find(params[:id])
  end

end
