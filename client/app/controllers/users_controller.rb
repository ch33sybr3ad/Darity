class UsersController < ApplicationController

  def show
    @user = User.find(session[:user_id])
    retreive_all_dares
  end

  def home
    @user = User.new
  end

  def index
    @users = User.all
  end

  def login
    @user = User.where(email: user_params["email"]).first
    if @user && @user.password == user_params["password"]
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  private

  def retreive_all_dares
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
    @pledged_dares = @user.pledged_dares
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
