class CharitiesController < ApplicationController

  def index
    @charities = Charity.all
  end

  def new
  end

  def create
  end

end
