Rails.application.routes.draw do
  root 'home#index'
  resources :session, only: [:index, :create, :destroy]
  resources :user, only: [:index, :create]
end
