Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root to: 'static_pages#home', as: :authenticated_root
  end

  root 'public#welcome'
  get '/join',    to: 'public#join_our_troop'
  get '/welcome', to: 'public#welcome'
  get '/photos',  to: 'public#photos'
  get '/eagle',   to: 'public#eagle_roll'
  get '/troop_calendar', to: 'public#troop_calendar'


  resources :articles
  get 'feed' => 'articles#feed', format: 'rss'
  get '/calendar', to: 'static_pages#calendar'

  resources :scouts
  resources :requirements
  resources :events do
    collection do
      get 'calendar_export'
    end
  end
  resources :scout_requirements
  resources :positions
  resources :ranks
  resources :patrols
  resources :categories
  resources :scout_rank_histories
  resources :scout_merit_badges
  resources :scout_events
  #resources :profiles, only: [:index, :show]
  resources :relationships


  namespace :admin do
    resources :users
    resources :file_uploads, except: [:edit, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
