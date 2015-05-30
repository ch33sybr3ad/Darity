class VideosController < ApplicationController

  def new
    @dare = Dare.find(params[:dare_id])
    @video = Video.new
  end

  #File methods: :size, :readlines
  def create
    @file = vid_params['file'].tempfile
    type = vid_params['file'].content_type
    client = YouTubeIt::Client.new(:username => ENV['GMAIL'], :password => ENV['GMAIL_PASSWORD'], :dev_key => ENV["YOUTUBE_API_KEY"])
    res = client.video_upload(@file, title: vid_params['title'], description: vid_params['description'], category: 'People', :keywords => ['darity', 'dare', 'charity'])
    @video = Video.new(url: res.player_url, description: vid_params["description"], title: vid_params['title'], dare_id: params[:dare_id])
    if @video.save
      redirect_to current_user
    else
      render html: "<h1>Error</h1>"
    end
  end

  private

  def vid_params
    params.require(:video).permit(:title, :description, :file)
  end

end
