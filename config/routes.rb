Rails.application.routes.draw do
 
  
  root 'events#index'

  resources :events
  resources :users, only: [:show]
  
 
  
  get 'static_pages/secret'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
