Rails.application.routes.draw do
  root to: "users#dash_board"
  devise_for :users
  resources :users do
    collection do
      post :create_new_user
    end
    member do
      get :dash_board
    end
  end
  resources :events do
    collection do
      get :registered_events
    end
    member do
      post :register
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post "login", to: "auth#login"
      resources :events, only: [ :index, :create ] do
        member do
          post :register
        end
      end
    end
  end
end
