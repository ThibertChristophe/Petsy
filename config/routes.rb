Rails.application.routes.draw do
  root "user#new"
  get "up" => "rails/health#show", :as => :rails_health_check
  resources :user, only: %i[new create]
end
