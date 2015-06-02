class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @dare = Dare.find(@comment.dare_id)
    if @comment.save
      render json: { comment: @comment, username: current_user.username }.to_json
    else
      return "fail!"
      #need error handling
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :dare_id)
  end

end
