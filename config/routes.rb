Rails.application.routes.draw do
  devise_for :views
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  # root 'devise/sessions#new'
end
