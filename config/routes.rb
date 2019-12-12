Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end

  namespace :api do

    #plants
    get 'plants' => 'plants#index'
    get 'plants/:id' => 'plants#show'
    post 'plants' => 'plants#create'

    #calendars
    get 'calendars' => 'calendars#index'
    get 'calendars/:id' => 'calendars#show'
    post 'calendars' => 'calendars#create'
  end
end
