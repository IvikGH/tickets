Rails.application.routes.draw do

  root to: 'tickets#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :tickets do
    resources :comments
  end
  resources :departments
  resources :statuses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
