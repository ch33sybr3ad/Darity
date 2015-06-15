require 'rails_helper'

RSpec.describe CharitiesController, type: :controller do

  render_views

	it 'should get all charities' do
    get :index
    response.status.should eq 200
    response.body.should include('Darity Charity')
	end

end
