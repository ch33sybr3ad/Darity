class UsersController < ApplicationController

  def show
    @user = User.find(session[:user_id])
    p @user
    p '####################'
    retreive_all_dares
  end

  def home
    @user = User.new
  end

  def index
    @user = User.new
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
    p @challenged_dares = @user.challenged_dares
    p @proposed_dares = @user.proposed_dares
    p @pledged_dares = @user.pledged_dares
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
