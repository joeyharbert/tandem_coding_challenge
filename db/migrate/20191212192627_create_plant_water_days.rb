class CreatePlantWaterDays < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_water_days do |t|
      t.integer :plant_id
      t.integer :water_day_id

      t.timestamps
    end
  end
end
