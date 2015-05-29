class UsersController < ApplicationController

  def show
    @user = User.find(session[:user_id])
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
    @pledged_dares = @user.pledged_dares
  end

  def home
    @user = User.new
  end

  def index
    @user = User.new
  end

  def login
    @user = User.where(email: params[:email]).first
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      render "show"
    end
  end

  private

end
