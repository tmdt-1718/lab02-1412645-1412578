Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only: [:index, :create, :destroy]
  resources :users, only: [:index, :create]
  resources :mails
end
