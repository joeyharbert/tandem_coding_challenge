class Api::PlantsController < ApplicationController
  def index
    @plants = Plant.all

    render "index.json.jbuilder"
  end

  def show
    @plant = Plant.find(params[:id])

    render "show.json.jbuilder"
  end

  def create
    @plant = Plant.create(
        name: params[:name],
        water_after: params[:water_after].to_i
      )

    if @plant.save
      render 'show.json.jbuilder', status: :created
    else
      render json: {errors: @plant.errors.full_messages}, status: :bad_request
    end
  end
end
