require 'rails_helper'

RSpec.describe DonationsController, type: :controller do

  render_views

  it 'should show everything' do
    get :show, { user_id: 1, id: 1 }
    response.status.should eq 200
    response.body.should include(User.first.username)
    response.body.should include(Dare.first.description)
    response.body.should include(Dare.first.daree.username)
  end
  
end
