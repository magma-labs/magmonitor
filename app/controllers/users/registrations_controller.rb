# frozen_string_literal: true

module Users
  module DeviseRegistrations
    # rubocop:disable Metrics/MethodLength, AbcSize, PerceivedComplexity
    def new
      build_resource({})
      resource.email = Invite.find_by_token(@token).email if @token
      yield resource if block_given?
      respond_with resource
    end
  end

  class RegistrationsController < Devise::RegistrationsController
    prepend DeviseRegistrations

    before_action :set_token, only: %i[new create]
    around_action :set_user_resource, only: [:create]

    protected

    def sign_up_params
      signup_params = devise_parameter_sanitizer.sanitize(:sign_up)
      @invite = Invite.find_by_token(params[:invite_token])
      signup_params = signup_params.merge(email: @invite.email) if @invite
      signup_params
    end

    private

    def set_token
      @token = params[:invite_token]
    end

    def set_user_resource
      yield
      return if @token.nil?
      org = @invite.organization
      resource.organizations.push(org)
      resource.fully_registered = true
      resource.save
    end
  end
end
