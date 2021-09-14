Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :test, only: :index
      resources :users, only: :index
      resources :friend_requests, only: [:index, :create]
      resources :friends, only: [:index, :create]
      resources :groups, only: [:index, :create, :show] do
        resources :messages, only: [:index, :create]
      end

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }

      namespace :auth do
        resources :sessions, only: :index
      end
    end
  end
end
