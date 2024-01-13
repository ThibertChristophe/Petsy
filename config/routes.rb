Rails.application.routes.draw do
  root "user#new"
  resources :user, only: %i[new create]
end
