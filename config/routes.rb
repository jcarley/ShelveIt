Shelveit::Application.routes.draw do
  
  root :to => "bookmarks#index"

  resources :bookmarks
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  match "/signup", :to => "users#new"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy"

end
