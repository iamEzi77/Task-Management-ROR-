Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  
  resources :projects

  namespace :admin do
    resources :dashboard
    resources :users
    get "employee_report/:id", to: "dashboard#report_generator", as: :employee_report
    get "all_employees", to: "dashboard#all_employees"
  end

  namespace :employee do
    resources :dashboard
  end

end

