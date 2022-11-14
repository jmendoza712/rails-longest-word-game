Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # New action router
  get "/new", to: "games#new"

  # Score action router
  post "/score", to: "games#score"

end
