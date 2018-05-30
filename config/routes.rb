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

  resources :provider, only: [:new, :create] do
    resources :survey, only: [:show, :edit]
  end
  resources :pathway, only: [:new, :create]
  resources :chart, only: [:show, :index]
  resources :home, only: [:index]
  resources :teacher, only: [:new, :create, :show, :update, :edit]
  resources :admin, only: [:show, :edit]
  resources :event do
    resources :survey
  end
  resources :participants, only: [:index]
  resources :student, only: [:new, :create, :show]
  resources :survey, only: [:show, :index, :edit, :update]
end
