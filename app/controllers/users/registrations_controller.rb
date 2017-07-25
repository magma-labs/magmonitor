# frozen_string_literal: true

module Users
  module DeviseRegistrations
    def new
      @token = params[:invite_token]
      build_resource({})
      resource.email = Invite.find_by_token(@token).email if @token
      yield resource if block_given?
      respond_with resource
    end

    def create # rubocop:disable Metrics/MethodLength, AbcSize, PerceivedComplexity
      token = params[:invite_token]
      invite = Invite.find_by_token(token)
      build_resource(sign_up_params)
      resource.email = invite.email if invite
      resource.save
      unless token.nil?
        org = invite.organization
        resource.organizations.push(org)
        resource.fully_registered = true
      end
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end

  class RegistrationsController < Devise::RegistrationsController
    prepend DeviseRegistrations
  end
end
