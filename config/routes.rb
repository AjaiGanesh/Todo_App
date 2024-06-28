Rails.application.routes.draw do
  resources :comments
  post "login", to: "api#login"
  get "logout", to: "base#logout"
  post "forgot_password", to: "api#forgot_password"
  post "new_password", to: "api#new_password"
  get "current_user", to: "base#current_user"
  get "status_index", to: "base#status_index"
  put "user/change_password", to: "users#change_password"
  resources :users
  resources :projects
  resources :tasks
  get "/priority_list", to: "priorities#index"
end
