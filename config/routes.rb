Rails.application.routes.draw do
  root 'constructions#index'
  devise_for :users

  resources :constructions, only: [:index, :new, :create]
  resources :lines, only: :none do
    resources :stations, only: [:index]
  end
end
