Rails.application.routes.draw do
  resources :projects
  resources :tasks
  get "/priority_list", to: "priorities#index"
end
