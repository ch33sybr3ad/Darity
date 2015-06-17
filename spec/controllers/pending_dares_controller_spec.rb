require 'rails_helper'

RSpec.describe PendingDaresController, type: :controller do

  render_views

  describe '#show' do
    it 'should show specific pending dares' do
      get :show, { id: 1 }, { user_id: 1 }
      response.status.should eq 200
      response.body.should include('Title')
      response.body.should include('Description')
    end
  end

  describe '#create' do
    it 'should create a pending dare' do
      post :create, { pending_dare: { title: "testing title", description: "testing description", twitter_handle: "testing_handle"} }, { user_id: 1 }
      response.status.should eq 302
      PendingDare.count.should eq 5
    end

    it 'should render status 422 if given bad pending dare' do
      post :create, { pending_dare: { title: "", description: "", twitter_handle: "testing_handle"} }, { user_id: 1 }
      response.status.should eq 422
    end
  end

end
