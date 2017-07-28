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

  resources :org, controller: :organizations do
    get 'invite'
    post 'invite', to: 'organizations#create_invite'
    get 'accept_invite'
    resources :sites do
      resources :historical_checks, only: %i[index show]
    end
  end

  mount Sidekiq::Web => '/async-web'
end
