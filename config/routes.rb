Rails.application.routes.draw do
  devise_for :views
  devise_for :users

  # resources :users, only: [:index, :show, :edit, :update]

  resources :teacher, only: [:show] do
    resources :event, only: [:index, :show]
  end

  resources :event

  resources :student, only: [:show] do
    resources :survey, only: [:show, :index]
  end

  devise_scope :user do
    root to: "devise/sessions#new", as: 'login'
  end
  # root 'devise/sessions#new'
end
