Shelveit::Application.routes.draw do

  root :to => "users#index"

  resources :bookmarks
  resources :users

  match "/signup", :to => "users#new"
  
  match "/login", :to => "users#login", :as => "login_users"
    
end
