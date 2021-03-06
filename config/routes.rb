Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :index
      resources :results, only: [:index]
      resources :cards, only: [:index, :create] do
        collection do
          get 'customer_create'
        end
      end
      resources :friend_requests, only: [:index, :create] do
        collection do
          delete 'refused_request'
        end
      end
      resources :friends, only: [:index, :create]
      resources :rules, only: [:index, :create]
      resources :group_requests, only: [:index, :create]
      resources :groups, only: [:index, :create, :show] do
        collection do
          get 'enter_group'
          delete 'refused_to_enter'
        end
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
