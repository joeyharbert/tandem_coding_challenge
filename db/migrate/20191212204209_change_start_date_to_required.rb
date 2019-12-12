class ChangeStartDateToRequired < ActiveRecord::Migration[5.2]
  def change
    change_column_null :calendars, :start_date, false
  end
end
