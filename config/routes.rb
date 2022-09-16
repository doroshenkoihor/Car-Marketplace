Rails.application.routes.draw do
  resources :cars
  resources :brands
  resources :dealers
  resources :models
  
  root "cars#index"
end
