Rails.application.routes.draw do
  root    'static_pages#home'
  get     '/signup',  to: 'users#new'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  post    '/signup',  to: 'users#create'
  delete  '/logout',  to: 'sessions#destroy'
  resources :users
  resources :tasks, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
end
