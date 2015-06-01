class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(uid: auth["uid"], provider: auth["provider"]).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to user, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out'
  end

  def signup
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated. Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
