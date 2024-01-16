Rails.application.routes.draw do
  get "searches/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # route for saving searches to search#save with a body of text
  post "searches/save"

  # Defines the root path route ("/")
  # root "articles#index"
  root "searches#index"
end
