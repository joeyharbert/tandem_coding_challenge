class Api::PlantsController < ApplicationController
  def index
    @plants = Plant.all

    render "index.json.jbuilder"
  end
end
