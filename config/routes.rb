Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only: [:index, :create, :destroy]
  resources :users, only: [:index, :create]
  resources :mails
  get "users/friendship", controller: "users#friendship"
  post "users/find", controller: "users#find"
  post "users/accept", controller: "users#accept"
  post "users/makefriend", controller: "users#makefriend"
  post "users/unfriend", controller: "users#unfriend"
  post "users/undorequest", controller: "users#undorequest"
end
