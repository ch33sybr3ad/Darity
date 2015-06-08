class RelationshipsController < ApplicationController

  def create
    relationship = Relationship.new(
      followee_id: params[:user_id],
      follower_id: current_user.id,
    )
    if relationship.save
      redirect_to user_path(params[:user_id])
    else
      render html: '<h1>error</h1>', status: 404
    end
  end

  def destroy
    relationship = Relationship.where(
      followee_id: params[:user_id],
      follower_id: current_user.id,
    ).first
    if relationship.destroy
      redirect_to user_path(params[:user_id])
    else
      render html: '<h1>error</h1>', status: 404
    end
  end

  def index
  end

end
