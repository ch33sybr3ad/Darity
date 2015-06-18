require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  render_views

git statu  describe '#create' do
    it 'should create a relationship' do
      get :show, { id: 1 }, { user_id: 1 }
      response.status.should eq 200
      response.body.should include('Title')
      response.body.should include('Description')
    end

    it 'should create a relationship' do
      get :show, { id: 1 }, { user_id: 1 }
      response.status.should eq 200
      response.body.should include('Title')
      response.body.should include('Description')
    end
  end

  describe '#destroy' do
    it 'should show specific pending dares' do
      get :show, { id: 1 }, { user_id: 1 }
      response.status.should eq 200
      response.body.should include('Title')
      response.body.should include('Description')
    end

    it 'should show specific pending dares' do
      get :show, { id: 1 }, { user_id: 1 }
      response.status.should eq 200
      response.body.should include('Title')
      response.body.should include('Description')
    end
  end

end
