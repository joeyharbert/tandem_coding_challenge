class WaterDay < ApplicationRecord
  has_many :plant_water_days
  has_many :plants, through: :plant_water_days
end
