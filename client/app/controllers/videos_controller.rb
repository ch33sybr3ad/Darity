class VideosController < ApplicationController

  def new
    @dare = Dare.find(params[:dare_id])
    @video = Video.new
  end

end
