Rails.application.routes.draw do

  resources :events
  get 'admin/home'

  devise_for :users
  root 'static_pages#home'

  resources :scouts
  resources :requirements
  resources :scout_requirements
  resources :positions
  resources :ranks
  resources :patrols
  resources :articles
  resources :categories
  resources :scout_rank_histories

  resources :profiles, only: [:index, :show]
  get '/admin', to: 'admin#home'
  get '/calendar', to: 'static_pages#calendar'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
