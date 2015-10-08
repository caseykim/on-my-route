Rails.application.routes.draw do
  root 'constructions#index'
  devise_for :users

  resources :constructions, except: :show
  resources :lines, only: :none do
    resources :stations, only: [:index]
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
end
