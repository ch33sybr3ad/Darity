class PendingDaresController < ApplicationController
  before_action :check_logged_in!

  def show
    @pending_dare = PendingDare.find(params[:id])
  end

  def create
    @pending_dare = PendingDare.new(pend_params)
    @pending_dare.proposer = current_user
    if @pending_dare.save
      redirect_tweet(dare: @pending_dare, user: current_user)
    else
      error_page(422)
    end
  end

  def pend_params
    params.require(:pending_dare).permit(:title, :description, :twitter_handle)
  end

end
