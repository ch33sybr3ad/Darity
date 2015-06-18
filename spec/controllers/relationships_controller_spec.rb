require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  render_views

  describe '#create' do
    it 'should create a relationship' do
      post :create, { user_id: 4 }, { user_id: 5 }
      response.status.should eq 302
      response.should redirect_to(user_path(id: 4))
    end

    it 'should render 422 page if invalid relationship' do
      post :create, { user_id: "" }, { user_id: 5 }
      response.status.should eq 422
    end
  end

  describe '#destroy' do
    it 'should show specific pending dares' do
      Relationship.create(followee_id: 4, follower_id: 5)
      expect(Relationship.count).to eq 11
      delete :destroy, { user_id: 4, id: 11}, { user_id: 5 }
      expect(Relationship.count).to eq 10
    end

    it 'should render 422 page if invalid relationship' do
      delete :destroy, { user_id: 4, id: 15}, { user_id: 5 }
      response.status.should eq 422
    end
  end

end
