Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
end
