Rails.application.routes.draw do
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

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
end
