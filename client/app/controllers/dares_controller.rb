class DaresController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
  end

  def show
    @dare = Dare.find(params[:id])
    @proposer = @dare.proposer
  end
end
