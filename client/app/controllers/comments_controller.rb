class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    #needs a redirect to somewhere!
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :dare_id)
  end

end
