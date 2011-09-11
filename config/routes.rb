Shelveit::Application.routes.draw do

  root :to => "bookmarks#home"
  get "bookmarks/add"

end
