# frozen_string_literal: true

module DeviseRegistrations
  extend ActiveSupport::Concern

  included do
    before_action :set_token, only: %i[new create]
    before_action :find_invite, only: %i[create new]
    before_action :autofill_email, only: %i[create]
    around_action :check_for_membership, only: [:create]
  end

  def new
    build_resource({})
    resource.email = Invite.find_by_token(@token).email if @token
    yield resource if block_given?
    respond_with resource
  end

  private

  def find_invite
    @invite = Invite.find_by_token(params[:invite_token])
  end

  def autofill_email
    params[:user][:email] = find_invite.email if find_invite
  end

  def set_token
    @token = params[:invite_token]
  end

  def check_for_membership
    yield
    return unless @token
    resource.organizations << @invite.organization
    resource.registration_finished
  end
end
