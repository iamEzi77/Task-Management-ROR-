Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  
  resources :projects

  namespace :admin do
    resources :dashboard
    # resources :tasks
  end

  namespace :employee do
    resources :dashboard
  end

end

