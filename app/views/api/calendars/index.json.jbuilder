json.array! @calendars.each do |calendar|
  json.id calendar.id
  json.start_date calendar.start_date
  json.water_days calendar.water_days
end