require 'spec_helper'
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it 'gets index' do
    get 'index'
  end

end
