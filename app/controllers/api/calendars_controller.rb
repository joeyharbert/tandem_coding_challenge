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
        #check if start_date is a monday, if not, make it a monday
        start_date = Date.parse(params[:start_date])
        if start_date.cwday != 1
          entered_date_number = start_date.cwday

          # increment date until monday (we get to 1 if the entered date was a sunday, otherwise we get to 8)
          while entered_date_number < 1 || entered_date_number < 8
            start_date += 1
            entered_date_number += 1
          end       
        end

        @calendar = Calendar.create(start_date: start_date)

        if @calendar.save
          #create water_days attached to calendar
          #make number of weeks for calendar scalable
          num_of_weeks = 0
          if params[:num_of_weeks]
            num_of_weeks = params[:num_of_weeks].to_i
            if num_of_weeks == 0
              render json: {error: "Please enter a valid number of weeks for the calendar"}
              return
            end
          else
            num_of_weeks = 12
          end

          num_of_days = num_of_weeks * 7
          current_date = start_date

          num_of_days.times do 
            WaterDay.create(date: current_date, calendar_id: @calendar.id)
            current_date += 1
          end

          #create all plants (this will be given to us from front end)
            plants_file = File.read(params[:plants].path)
            #check and make sure imported file is .JSON
            if File.extname(params[:plants].path) != ".json"
              render json: {error: "please upload a .json file of plant data"}
              return
            end
            plant_data = JSON.parse(plants_file)
            plant_array = []

            plant_data.each do |plant| 
              plant_array.push(
                Plant.create(
                name: plant["name"], 
                water_after: plant["water_after"]
                ))
            end

            puts plant_array
          #calculate which plants for which days and attach


          render 'show.json.jbuilder'
        else
          render json: {errors: @plant.errors.full_messages}, status: :bad_request
        end
      else
        render json: {error: "Please enter a start date"}
      end
    end
end
