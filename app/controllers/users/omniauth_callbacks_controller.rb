# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      perform_registration(Magmonitor::UserRegistration::GithubService)
    end

    def google_oauth2
      perform_registration(Magmonitor::UserRegistration::GoogleOauth2Service)
    end

    def failure
      redirect_to root_path
    end

    def perform_registration(klass)
      user = klass.new(request.env['omniauth.auth']).persist
      sign_in_and_redirect user, event: :authentication
    end
  end
end
