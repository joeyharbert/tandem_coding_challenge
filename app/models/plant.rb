class Plant < ApplicationRecord
  has_many :plant_water_days
  has_many :water_days, through: :plant_water_days
end
