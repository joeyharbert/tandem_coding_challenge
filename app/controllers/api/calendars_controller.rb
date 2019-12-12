class Api::CalendarsController < ApplicationController
  def index 
    @calendars = Calendar.all

    render "index.json.jbuilder"
  end
end
