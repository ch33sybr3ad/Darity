class GenerateDaresController < ApplicationController

  def generate
    @generateDare = GenerateDare.order("RANDOM()").first
    render json: @generateDare.to_json
  end

end
