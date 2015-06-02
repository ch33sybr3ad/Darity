class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:user_id] = user.id
  end

  def _404
    render :'404', layout: false, status: 404
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def find_user
    begin
    @user = User.find(params[:user_id] || params[:id])
    rescue ActiveRecord::RecordNotFound
      @user = User.new
      _404
    end
  end

  def find_dare
    begin
    @dare = Dare.find(params[:dare_id] || params[:id])
    rescue ActiveRecord::RecordNotFound
      @dare = Dare.new
      _404
    end
  end
end
