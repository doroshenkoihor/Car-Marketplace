Rails.application.routes.draw do
  devise_for :users
  resources :cars
  resources :brands
  resources :dealers
  resources :models
  
  root "cars#index"
end
