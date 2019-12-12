json.array! @plants.each do |plant|
  json.id plant.id
  json.name plant.name
  json.water_after plant.water_after
end