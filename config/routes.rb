Crmfieldupdate::Application.routes.draw do

  devise_for :users
  resources :mappings
  root to: "mappings#index"
  match "/passwords/edit", via: :get
  match "/passwords", via: :put, action: :update, controller: :passwords
end
