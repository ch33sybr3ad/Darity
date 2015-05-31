class PendingDaresController < ApplicationController

  def show
    @pending_dare = PendingDare.find(params[:id])
  end

end
