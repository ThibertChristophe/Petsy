Rails.application.routes.draw do
  # edition de profil
  get 'profile', to: 'users#edit', as: :profile
  patch 'profile', to: 'users#update'
  resources :users, only: %i[new create] do
    # va generer une route /:id/confirm
    member do
      get 'confirm'
    end
  end
  root 'users#new'
end
