Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations"}
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  authenticated :user do
    root to: 'static_pages#home', as: :authenticated_root
  end

  # Public Facing Web Pages
  root 'public#welcome'
  get '/join',    to: 'public#join_our_troop'
  get '/welcome', to: 'public#welcome'
  get '/photos',  to: 'public#photos'
  get '/eagle',   to: 'public#eagle_roll'
  get '/troop_calendar', to: 'public#troop_calendar'


  # Troop Private Pages
  resources :articles
  get 'feed' => 'articles#feed', format: 'rss'
  get '/calendar', to: 'static_pages#calendar'

  resources :scouts
  resources :requirements
  resources :scout_requirements
  resources :scout_positions
  resources :scout_trainings
  resources :scout_rank_histories
  resources :scout_merit_badges
  resources :scout_awards
  resources :scout_events
  resources :youth_awards
  resources :youth_award_requirements
  resources :positions
  resources :ranks
  resources :patrols
  resources :relationships
  resources :adults
  resources :adult_positions
  resources :adult_training_courses, only: :index
  resources :adult_trainings
  resources :adult_vehicles
  resources :adult_events, only: [:new, :index]
  resources :vehicles, except: :show
  resources :event_locations
  resources :events do
    collection do
      get 'calendar_export'
    end
  end
  resources :categories do
    collection do
      get 'check_category'
    end
  end

  # Reports
  get '/reports/scout_detail_report', to: 'reports#scout_detail_report'
  get '/reports/patrol_report', to: 'reports#patrol_report'
  get '/reports/event_attendance_report', to: 'reports#event_attendance_report'

  # Admin Pages
  namespace :admin do
    resources :users
    resources :file_uploads, except: [:edit, :show] do
      collection do
        get 'import_file'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
