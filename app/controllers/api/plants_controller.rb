class Api::PlantsController < ApplicationController
  def index
    @plants = Plant.all

    render "index.json.jbuilder"
  end

  def show
    @plant = Plant.find(params[:id])

    render "show.json.jbuilder"
  end
end
