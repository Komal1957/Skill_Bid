Rails.application.routes.draw do
  get "users/dashboard"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "messages/create"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "home/index"
  post '/ai/suggest', to: 'ai#suggest_description'
  resources :requests
  devise_for :users

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
  # Nested Resources
  resources :requests do
    resources :bids, only: [ :create, :edit, :update, :destroy]
    resources :messages, only: [:create]
  end

  resources :requests do
    resources :bids, only: [:create, :destroy]
    resources :messages, only: [:create]
    # Add payments route
    resources :payments do
      member do
        patch :release_funds
      end
    end    
  end
  
  # Add success route (outside the block)
  get 'payments/success', to: 'payments#success', as: :payment_success
end