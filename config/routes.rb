Rails.application.routes.draw do
  resources :posts
  resources :pets
  # edition de profil
  get 'profile', to: 'users#edit', as: :profile
  patch 'profile', to: 'users#update'

  resources :passwords, only: %i[new create update edit]
  resources :sessions, only: %i[create]
  get '/login', to: 'sessions#new', as: :new_session
  get '/logout', to: 'sessions#destroy', as: :destroy_session
  resources :users, only: %i[new create edit destroy] do
    # va generer une route /:id/confirm
    member do
      get 'confirm'
    end
  end
  root 'users#new'
end
