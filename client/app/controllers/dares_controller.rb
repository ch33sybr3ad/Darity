class DaresController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @dares = @user.challenged_dares
  end

  def show
    @dare = Dare.find(params[:id])
    @proposer = @dare.proposer
  end
end
