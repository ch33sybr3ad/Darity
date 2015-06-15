class AccountActivationsController < ApplicationController

  # activation email currently turned off
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login user
      flash[:success] = "Account activated! Welcome to Darity."
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
