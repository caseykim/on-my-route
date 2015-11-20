Rails.application.routes.draw do
  authenticated :user do
    root 'constructions#index', as: 'authenticated_root'
  end
  root 'homes#index'
  devise_for :users

  resources :constructions, except: :show

  resources :lines, only: :none do
    resources :stations, only: :index
    resources :constructions, only: :index
  end

  resources :users, only: :show do
    resources :reminders, only: :create
  end

  resources :reminders, only: :destroy

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
end
