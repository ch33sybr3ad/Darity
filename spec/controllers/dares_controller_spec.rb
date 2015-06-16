require 'rails_helper'

RSpec.describe DaresController, type: :controller do

  render_views

  it 'should show everything' do
    get :show, { user_id: 1, id: 1 }
    response.status.should eq 200
    response.body.should include(User.first.username)
    response.body.should include(Dare.first.description)
    response.body.should include(Dare.first.daree.username)
  end

  it 'should render new dare form' do
    get :new, { user_id: 1 }, { user_id: 1 }
    response.status.should eq 200
    response.body.should include("Can't think of a Dare? Click the generate button to get the creative juices flowing!")
  end 

  it 'should create a new dare' do
    post :create, { user_id: 1, dare: { title: "test dare title",description: "test dare description", daree_id: 2 } }, { user_id: 1 }
    response.status.should eq 302
    Dare.count.should eq(7)
  end

  it 'should not create a new dare' do
    post :create, { user_id: 1, dare: { title: "",description: "", daree_id: 2 } }, { user_id: 1 }
    response.status.should eq 422
    Dare.count.should eq(6)
  end

  it 'should show form on edit page' do
    get :edit, { user_id: 1, id: 1 }, { user_id: 1 }
    response.status.should eq 200
    response.body.should include('Deliver a 3-5 minute lecture to your parents entitled') 
  end

  it 'should update dare' do
    patch :update, { user_id: 1, id: 1, dare: { title: "test dare title",description: "test dare description", daree_id: 2 } }, { user_id: 1 }
    response.status.should eq 302
    Dare.first.title.should eq "test dare title"
    Dare.first.description.should eq "test dare description"
  end

  it 'should get 401 error with invalid user' do
    get :set_price, { user_id: 1, id: 1 }, { user_id: 1 }
    response.status.should eq 401
  end

  it 'should render set price form' do
    get :set_price, { user_id: 2, id: 1 }, { user_id: 2 }
    response.status.should eq 200
  end

  it 'should set price of dare' do
    patch :put_price, { user_id: 2, id: 1, dare: { price: 10 } }, { user_id: 2 }
    response.status.should eq 302
    Dare.first.price.should eq 10
  end

  it 'should destroy dare' do
    delete :destroy, { user_id: 1, id: 1 }, { user_id: 1 }
    response.status.should eq 302
    Dare.count.should eq 5
  end

  it 'should allow pledger to approve of dare' do
    patch :approve, { dare_id: 2 }, { user_id: 4 }
    response.status.should eq 200
    Dare.find(2).approval_rate.should eq(1)
  end

  it 'should not allow a non-pledger to approve of dare' do
    patch :approve, { dare_id: 2 }, { user_id: 2 }
    response.status.should eq 200
    Dare.find(2).approval_rate.should eq(0)
  end

  it 'should allow pledger to disapprove of dare' do
    Donation.find(1).update_attributes(approve: 1)
    patch :disapprove, { dare_id: 2 }, { user_id: 1 }
    response.status.should eq 200
    Dare.find(2).approval_rate.should eq(0.5)
  end

  it 'should not allow non-pledger to disapprove of dare' do
    patch :disapprove, { dare_id: 2 }, { user_id: 2 }
    response.status.should eq 200
    Dare.find(2).approval_rate.should eq(0)
  end
end
