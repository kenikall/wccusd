Rails.application.routes.draw do

  root to: "home#index"
  devise_for :users

  resources :home, only: [:index]
  resources :teacher, only: [:show]
  resources :admin, only: [:show]
  resources :event
  resources :student, only: [:show] do
    resources :survey, only: [:show, :index]
  end
end
