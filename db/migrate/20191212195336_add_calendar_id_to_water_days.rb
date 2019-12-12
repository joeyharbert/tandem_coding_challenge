class AddCalendarIdToWaterDays < ActiveRecord::Migration[5.2]
  def change
    add_column :water_days, :calendar_id, :integer
  end
end
