require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  render_views

  it 'create a comment' do
    post :create, { comment: {body: "testing", author_id: 1, dare_id: 1} }, { user_id: 1 }
    response.status.should eq 200
    response.body.should include("testing")
  end

  it 'should not create a comment without current user' do
    post :create, { comment: {body: "testing", author_id: 1, dare_id: 1} }, { user_id: nil }
    response.status.should eq 302
  end

  it 'should not create a comment without body' do
    post :create, { comment: {body: "", author_id: 1, dare_id: 1} }, { user_id: 1 }
    response.status.should eq 422
  end

  it 'should upvote the comment' do
    post :upvote, { id: 1, like: {id: 1} }, { user_id: 1 }
    JSON.parse(response.body)["likes_count"].should eq(1)
    response.status.should eq 200
  end

  it 'should not increase count on second upvote' do
    post :upvote, { id: 1, like: {id: 1} }, { user_id: 1 }
    JSON.parse(response.body)["likes_count"].should eq(1)
    response.status.should eq 200
  end

  it 'should downvote the comment' do
    post :downvote, { id: 1, like: {id: 1} }, { user_id: 1 }
    JSON.parse(response.body)["likes_count"].should eq(-1)
    response.status.should eq 200
  end

  it 'should not decrease count on second downvote' do
    post :downvote, { id: 1, like: {id: 1} }, { user_id: 1 }
    JSON.parse(response.body)["likes_count"].should eq(-1)
    response.status.should eq 200
  end
end
