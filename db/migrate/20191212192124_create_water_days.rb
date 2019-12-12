class CreateWaterDays < ActiveRecord::Migration[5.2]
  def change
    create_table :water_days do |t|
      t.date :date

      t.timestamps
    end
  end
end
