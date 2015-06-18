require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  render_views

  describe '#destroy' do
    it 'should log user out' do
      session[:user_id] = User.first.id
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end
  end

  describe '#login' do
    it 'should login user' do
      post :login, { user: { email: User.first.email, password: "123456"} }
      expect(session[:user_id]).to eq(User.first.id)
    end

    it 'should not login invalid user' do
      post :login, { user: { email: User.first.email, password: "12345678"} }
      expect(flash[:error]).to eq('Invalid Info')
    end
  end


end