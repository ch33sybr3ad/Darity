require 'rails_helper'

RSpec.describe GenerateDaresController, type: :controller do

  describe '#generate' do
    it 'should generate a random dare' do
      get :generate
      response.status.should eq 200
    end
  end

end
