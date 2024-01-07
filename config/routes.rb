Rails.application.routes.draw do

  root 'home#welcome'
  get 'home', to: 'home#welcome', as: '/'

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :authentication, path:'', as:'' do 
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
  end

  resources :archives, only: [:index, :create, :destroy], param: :note_id
  resources :tags, except: :show
  resources :notes, path: '/active'

end
