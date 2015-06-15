class CharitiesController < ApplicationController

  def index
    @charities = Charity.paginate(page: params[:page], :per_page => 10)
  end

end
