json.id @calendar.id
json.start_date @calendar.start_date
json.water_days do
  json.array! @calendar.water_days.each do |water_day|
    json.id water_day.id
    json.date water_day.date
    json.plants do
      json.array! water_day.plants.each do |plant|
        json.id plant.id
        json.name plant.name
      end
    end
  end
end