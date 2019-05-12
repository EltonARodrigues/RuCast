Rails.application.routes.draw do
  #get 'cast/new'
  #get '/cast'  => 'cast#index'
  #post '/cast/create'
  #get '/home/index'
  #delete '/cast/:id(.:format)', :to => 'cast#destroy'
  #delete "cast/:id" => "cast#destroy", as: :delete
  

  root 'home#index'

  resources :cast, only: [:create, :show, :index, :destroy]
  resources :users, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
 