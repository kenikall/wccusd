Rails.application.routes.draw do

  root to: "home#index"

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users', to: 'users#show', :as => :user_root
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  resources :provider, only: [:new, :create]
  resources :home, only: [:index]
  resources :teacher, only: [:new, :create, :show, :update]
  resources :admin, only: [:show]
  resources :event do
    resources :survey#, only: [:index]
  end
  resources :participants, only: [:index]
  resources :student, only: [:new, :create, :show]
  resources :survey, only: [:show, :index, :edit, :update]
end
