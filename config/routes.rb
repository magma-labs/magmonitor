# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations'
  }
  root 'home#index'

  resource :registration_flow, controller: :registration_flow, only: %i[new create]
  resource :groups_manager, controller: :groups_manager do
    get 'index'
  end
  get 'groups_manager/:id/show_users', to: 'groups_manager#show_users', as: 'show_users'

  resources :org, controller: :organizations do
    get 'invite'
    post 'invite', to: 'organizations#create_invite'
    get 'accept_invite'
    resources :sites do
      resources :historical_checks, only: %i[index show]
    end
    namespace :api do
      namespace :v1 do
        resources :users do
          collection do
            get 'autocomplete'
          end
        end
        resources :assignments
      end
    end
  end

  namespace :api do
    namespace :v1 do
      get 'current_org', to: 'organizations#current'
    end
  end

  mount Sidekiq::Web => '/async-web'
end
