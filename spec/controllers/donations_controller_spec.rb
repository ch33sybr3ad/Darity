require 'rails_helper'

RSpec.describe DonationsController, type: :controller do

  render_views

  describe '#new' do
    it 'should should donation form' do
      get :new, { dare_id: 2 }, { user_id: 1 }
      response.status.should eq 200
      response.body.should include(Dare.second.charity.name)
      response.body.should include(Dare.second.daree.username)
    end
  end

  describe '#create' do
    it 'should create a dare' do
      post :create, { dare_id: 2, donation: { donation_amount: 1 } }, { user_id: 5 }
      response.status.should eq 302
      response.should redirect_to(pay_donations_path(id: Donation.last.id))
    end
  end

  describe '#pay' do
    it 'should show pay checkout form' do
      Donation.create(pledger_id: 3, pledged_dare_id: 2, donation_amount: 1) 
      get :pay, { dare_id: 2, id: Donation.last.id }, { user_id: 3 }
      response.status.should eq 200
      response.body.should include(Dare.second.charity.name)
      response.body.should include(Dare.second.daree.username)
    end

    it 'should only allow donation pledgder to pay' do 
      Donation.create(pledger_id: 3, pledged_dare_id: 2, donation_amount: 1) 
      get :pay, { dare_id: 2, id: Donation.last.id }, { user_id: 2 }
      response.status.should eq 401
    end
  end

end
