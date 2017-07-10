# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      user = Magmonitor::UserRegistration::GithubService.new(request.env['omniauth.auth']).persist
      sign_in_and_redirect user, event: :authentication
    end

    def google_oauth2
      user = Magmonitor::UserRegistration::GoogleOauth2Service
          .new(request.env['omniauth.auth']).persist
      sign_in_and_redirect user, event: :authentication
    end

    def failure
      redirect_to root_path
    end
  end
end
