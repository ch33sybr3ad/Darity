class PendingDaresController < ApplicationController

  def show
    @pending_dare = PendingDare.find(params[:id])
  end

  def create
    if !current_user
      redirect_to new_user_path
    else
      @pending_dare = PendingDare.new(pend_params)
      @pending_dare.proposer = current_user
      if @pending_dare.save
        redirect_tweet(dare: @pending_dare, user: current_user)
      else
        render html: 'fail'
      end
    end
  end

  def pend_params
    params.require(:pending_dare).permit(:title, :description, :twitter_handle)
  end

end
