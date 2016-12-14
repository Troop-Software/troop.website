Rails.application.routes.draw do


  devise_for :users
  root 'static_pages#home'
  
  resources :articles
  get '/calendar', to: 'static_pages#calendar'
  resources :events
  resources :scouts
  resources :requirements
  resources :scout_requirements
  resources :positions
  resources :ranks
  resources :patrols
  resources :categories
  resources :scout_rank_histories
  resources :scout_merit_badges
  resources :scout_events
  resources :profiles, only: [:index, :show]

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
