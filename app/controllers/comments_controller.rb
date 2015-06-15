class CommentsController < ApplicationController
  before_action :check_logged_in! 
  before_action :find_like, only: [:upvote, :downvote]
  before_action :find_comment, only: [:upvote, :downvote]

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { comment: comment, username: current_user.username,
       image_url: current_user.image_url }.to_json
    else
      _422
    end
  end

  def upvote
    @like.update_attributes(value: 1)
    @comment.update_attributes(likes_count: @comment.total_likes)
    render json: @comment
  end

  def downvote
    @like.update_attributes(value: -1)
    @comment.update_attributes(likes_count: @comment.total_likes)
    render json: @comment
  end


  private

    def comment_params
      params.require(:comment).permit(:body, :author_id, :dare_id)
    end

    def like_params
      params.require(:like).permit(:id)
    end

    def find_like
      @like = Like.find_or_create_by(comment_id: like_params["id"] ,user_id: current_user.id)
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end

end
