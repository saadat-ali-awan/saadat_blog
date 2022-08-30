Rails.application.routes.draw do
  devise_for :users
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts", to: "posts#index", as: 'posts'
  get "/users/posts/new", to: "posts#new", as: "new_post"
  post "/users/:user_id/posts/:id/comment", to: "comments#comment", as: "new_comment" 
  delete "/users/comment/:id", to: "comments#destroy", as: "delete_comment" 
  post "/users/:user_id/posts/:id/like", to: "likes#like", as: "new_like"
  post "users/:user_id/posts", to: "posts#create"
  delete "/posts/:post_id/delete", to: "posts#destroy", as: "delete_post"
  get "users/:user_id/posts/:id", to: "posts#show", as: "user_post"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
