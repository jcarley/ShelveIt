Shelveit::Application.routes.draw do

  root :to => "users#index"
  
  get "users/index"

  post "users/create"

  # match "/signup", :to => "users#new"
  get "users/new"

  post "users/login"
  
  resources :bookmarks
  
end
