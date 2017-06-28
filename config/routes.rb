# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'

  resource :registration_flow, controller: :registration_flow, only: %i[new create]

  resources :org, controller: :organizations do
    resources :sites
  end

  mount Sidekiq::Web => '/async-web'
end
