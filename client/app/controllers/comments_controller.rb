class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @dare = Dare.find(@comment.dare_id)
    if @comment.save
      binding.pry
      render json: { comment: @comment, username: current_user.username }.to_json
    else
      return "fail!"
      #need error handling
    end
  end

  def upvote
    binding.pry
    # like = Like.create(comment_id: ,user_id: current_user.id)
    @comment = Comment.find(params[:id])
    @comment.likes_count += 1
    @comment.save
    render json: @comment
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.likes_count -= 1
    @comment.save
    render json: @comment
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :dare_id)
  end

  def like_params
    params.require(:like).permit(:comment_id, :user_id)
  end

  

end
