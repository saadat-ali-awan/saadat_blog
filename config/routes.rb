Rails.application.routes.draw do
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts", to: "posts#index"
  get "users/:user_id/posts/:id", to: "posts#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
