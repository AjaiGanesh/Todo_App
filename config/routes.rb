Rails.application.routes.draw do
  post "login", to: "api#login"
  get "logout", to: "base#logout"
  post "forgot_password", to: "api#forgot_password"
  post "new_password", to: "api#new_password"
  put "change_password", to: "users#change_password"
  resources :users
  resources :projects
  resources :tasks
  get "/priority_list", to: "priorities#index"
end
