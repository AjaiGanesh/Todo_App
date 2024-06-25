Rails.application.routes.draw do
  post "login", to: "api#login"
  get "logout", to: "base#logout"
  resources :users
  resources :projects
  resources :tasks
  get "/priority_list", to: "priorities#index"
end
