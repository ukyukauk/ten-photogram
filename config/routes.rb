require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  devise_for :users

  root to: 'apps/posts#index'

  scope module: :apps do
    resources :posts do
      resources :comments, only: [:index, :new, :create]
    end

    resource :profile, only: [:show] do
      resource :avatar, only: [:update]
    end

    resources :accounts, only: [:show] do
      resources :followers, only: [:index]
      resources :followings, only: [:index]
      resources :account_posts, only: [:index]
    end
  end

  namespace :api, defaults: { format: :json } do
    scope '/posts/:post_id' do
      resource :like, only: [:show, :create, :destroy]
    end

    scope '/accounts/:account_id' do
      resources :follows, only: [:create]
      resources :unfollows, only: [:create]
    end
  end

end
