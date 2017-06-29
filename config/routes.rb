Rails.application.routes.draw do

  root to: 'tickets#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :tickets do
    collection do
      get 'search'
    end

    resources :comments
  end
  resources :departments
  resources :statuses
end
