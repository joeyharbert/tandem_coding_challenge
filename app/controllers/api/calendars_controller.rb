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
            plant_data = params[:plants]
            plant_array = []

            plant_data.each do |plant| 
              plant_array.push(
                Plant.create(
                name: plant["name"], 
                water_after: plant["water_after"]
                ))
            end

          #calculate which plants for which days and attach
          #for times sake, this is the most straightforward logic I could come up with
          #TODO: I would like to come back and make this algorithm more efficient time allowing
            #loop through all of the plants and attach them to their water days
            water_days = @calendar.water_days
            plant_array.each do |plant|
              #we start water_time at 0 so that all plants get assigned to be watered on the start day
              water_time = 0
              day_index = 0

              water_days.each do |water_day|
                #if today is water day
                if water_time == 0
                  #if today is not a weekend day
                  if water_day.date.cwday < 6
                    PlantWaterDay.create(plant_id: plant.id, water_day_id: water_day.id)
                    water_time = plant.water_after
                  else
                    #it is a weekend day, if saturday: water friday
                    #if sunday: water monday

                    if water_day.date.cwday == 6
                      #saturday
                      PlantWaterDay.create(plant_id: plant.id, water_day_id: water_days[day_index - 1].id)
                      water_time = plant.water_after - 1
                    else
                      #sunday
                      #check that we're not at the end of the calendar
                      if water_days[day_index] != water_days.last
                        PlantWaterDay.create(plant_id: plant.id, water_day_id: water_days[day_index + 1].id)
                        water_time = plant.water_after + 1
                      end
                    end
                  end
                end

                water_time -= 1
                day_index += 1
              end
            end

          render 'show.json.jbuilder'
        else
          render json: {errors: @plant.errors.full_messages}, status: :bad_request
        end
      else
        render json: {error: "Please enter a start date"}
      end
    end
end
