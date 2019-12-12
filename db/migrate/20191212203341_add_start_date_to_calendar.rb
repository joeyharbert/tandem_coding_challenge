class AddStartDateToCalendar < ActiveRecord::Migration[5.2]
  def change
    add_column :calendars, :start_date, :date
  end
end
