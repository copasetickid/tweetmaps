class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  include UserConcern


  # GET/PATCH /users/:id/finish_signup
  def finish_signup

    if request.get? && current_user.email_verified?
      redirect_to dashboard_path(current_user)
    elsif request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
       #@user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to dashboard_path(@user), notice: 'Your email was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
