Rails.application.routes.draw do
  devise_for :users
  resources :cars
  resources :brands
  resources :dealers
  resources :models
  resources :favorites
  root "cars#index"
end
