class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @dare = Dare.find(@comment.dare_id)
    if @comment.save
      render json: { comment: @comment, username: current_user.username,
       image_url: current_user.image_url }.to_json
    else
      return "fail!"
      #need error handling
    end
  end

  def upvote
    like = Like.find_or_create_by(comment_id: like_params["id"] ,user_id: current_user.id)
    like.value = 1
    like.save
    count = Like.where(comment_id: like_params["id"])
              .inject(0) { |sum, like| sum + like.value }

    comment = Comment.find(like_params['id'])
    comment.likes_count = count
    comment.save
    render json: comment
  end

  def downvote
    like = Like.find_or_create_by(comment_id: like_params["id"] ,user_id: current_user.id)
    like.value = -1
    like.save
    count = Like.where(comment_id: like_params["id"])
              .inject(0) { |sum, like| sum + like.value }
    comment = Comment.find(params[:id])
    comment.likes_count = count
    comment.save
    render json: comment
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :dare_id)
  end

  def like_params
    params.require(:like).permit(:id)
  end



end
