

class CharitiesController < ApplicationController


  def index
    response = HTTParty.get('https://www.kimonolabs.com/api/e8cai98q?apikey=jR0ep0PlzRAYmFSLYW4sScLoay3VFcDE')
    charities_array = response["results"]["collection1"]

    binding.pry
  end

  def new
  end

  def create
  end

end
