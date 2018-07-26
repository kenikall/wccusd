Rails.application.routes.draw do

  root to: "users#show"

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users', to: 'users#show', :as => :user_root
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  post "graph/format"
  post "graph/teacher"

  # get "chart/participation"
  # get "chart/activities"
  # get "chart/outcomes"

  resources :provider, only: [:new, :create] do
    resources :survey, only: [:show, :edit]
  end
  resources :pathway, only: [:new, :create]
  resources :home, only: [:index]
  resources :chart, only: [:index, :show]
  resources :teacher, only: [:new, :create, :show, :update, :edit]
  resources :admin, only: [:show, :edit]
  resources :event do
    resources :survey
  end
  resources :participants, only: [:index]
  resources :selector
  resources :student, only: [:new, :create, :show]
  resources :survey, only: [:show, :index, :edit, :update]
  resources :complete, only: [:new]
end
