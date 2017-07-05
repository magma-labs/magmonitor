# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      check_for_user_registration 'GitHub'
    end

    def google_oauth2
      check_for_user_registration 'Google'
    end

    def failure
      redirect_to root_path
    end

    private

    def check_for_user_registration(provider)
      @user = User.find_by(email: request.env['omniauth.auth'][:info].email)

      if @user && user_exists_with_provider(@user, provider)
        flash[:success] = "Logged in through #{provider}"
        sign_in_and_redirect @user, event: :authentication
      elsif @user && !user_exists_with_provider(@user, provider)
        flash[:error] = "You need to log in with #{@user.provider}"
        redirect_to root_path
      else
        register_new_user
      end
    end

    def user_exists_with_provider(user, provider)
      user.provider == provider.downcase
    end

    def register_new_user
      @user = User.from_omniauth(request.env['omniauth.auth'])

      return unless @user
      flash[:success] = "Logged in through #{@user.provider}"
      sign_in_and_redirect @user, event: :authentication
    end
  end
end
