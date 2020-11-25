Rails.application.routes.draw do
  root 'dashboard#index'
  get 'dashboard/index'
  post 'dashboard/index'
  
  post 'appointments/new'
  get 'appointments/schedule', to: "appointments#schedule", as: "schedule"

  resources :appointments
  resources :patients
  resources :doctors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
