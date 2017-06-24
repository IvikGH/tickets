Rails.application.routes.draw do

  root to: 'tickets#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :tickets
  resources :departments
  resources :statuses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
