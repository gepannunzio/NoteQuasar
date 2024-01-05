Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tags, except: :show
  resources :notes, path: '/'

end
