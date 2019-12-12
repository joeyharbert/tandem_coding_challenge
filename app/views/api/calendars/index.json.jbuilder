json.array! @calendars.each do |calendar|
  json.id calendar.id

  json.water_days calendar.water_days
end