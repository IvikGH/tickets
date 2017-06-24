Rails.application.routes.draw do
  root to: 'tickets#index'
  resources :tickets
  resources :departments
  resources :statuses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
