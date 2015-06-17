class GenerateDaresController < ApplicationController

  def generate
    generate_dare = GenerateDare.order("RANDOM()").first
    if !!generate_dare
      render json: generate_dare.to_json
    else
      error_page(404)
    end
  end

end
