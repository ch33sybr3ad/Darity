

class CharitiesController < ApplicationController


  def index
    @charities = Charity.all

    # binding.pry
  end

  def new
  end

  def create
  end

end
