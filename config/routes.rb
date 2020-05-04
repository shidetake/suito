Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root   'static_pages#home'
  get    '/help',     to: 'static_pages#help'
  get    '/about',    to: 'static_pages#about'
  get    '/contact',  to: 'static_pages#contact'
  get    '/settings', to: 'static_pages#settings'
  get    '/signup',   to: 'users#new'
  post   '/signup',   to: 'users#create'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  resources :users
  resources :transactions
  resources :categories, only: :index
  resources :groups, only: [:new, :create, :edit, :update]
  resources :sources, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :analysis, only: :show
end
