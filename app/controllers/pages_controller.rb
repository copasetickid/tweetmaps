class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = User.friendly.find(params[:id])
  end

end
