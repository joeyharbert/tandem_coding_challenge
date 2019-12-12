class Api::CalendarsController < ApplicationController
  def index 
    @calendars = Calendar.all

    render 'index.json.jbuilder'
  end

  def show
    @calendar = Calendar.find(params[:id])

    render 'show.json.jbuilder'
  end

  def create
      #create calendar
      if params[:start_date]
        @calendar = Calendar.create(start_date: params[:start_date])
        
        #create water_days attached to calendar


        #create all plants (this will be given to us from front end)
          #for now, we will just use all plants in database

        #calculate which plants for which days and attach

        if @calendar.save
          render 'show.json.jbuilder'
        else
          render json: {errors: @plant.errors.full_messages}, status: :bad_request
        end
      else
        render json: {error: "Please enter a start date"}
      end
    end
end
