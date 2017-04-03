Rails.application.routes.draw do
  # get 'survey/show'

  # get 'survey/index'

  # get 'student/show'

  devise_for :views
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  resources :student, only: [:show] do
    resources :survey, only: [:show, :index]
  end

  devise_scope :user do
    root to: "devise/sessions#new", as: 'login'
  end
  # root 'devise/sessions#new'
end
