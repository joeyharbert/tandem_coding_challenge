class Api::CalendarsController < ApplicationController
  def index 
    @calendars = Calendar.all

    render 'index.json.jbuilder'
  end

  def show
    @calendar = Calendar.find(params[:id])

    render 'show.json.jbuilder'
  end
  
end
