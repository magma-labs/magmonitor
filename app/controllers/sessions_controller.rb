# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :user_signed_in?, :check_user_registration

  def create
    user = Magmonitor::UserRegistrationService.new(request.env['omniauth.auth']).perform
    if user
      session[:user_id] = user.id
      message = 'Welcome'
    end
    redirect_to root_url, notice: message
  end
end
