Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'events#index'

  resources :events, only: [:index, :show, :new, :create] do
    member do
      get 'rsvp'
      get 'cancel_rsvp'
    end
  end

  resources :users, only: [:show]
end
