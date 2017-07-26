# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_user_registration

  helper_method :check_user_registration,
                :current_org,
                :user_organizations,
                :user_is_organization_owner?

  private

  def check_user_registration
    redirect_to new_registration_flow_path if user_signed_in? && !current_user.fully_registered?
  end

  def current_org
    @current_org ||= current_user.find_organization(params[:org_id])
  end

  def user_organizations
    @user_organizations ||= current_user.organizations
  end

  def user_is_organization_owner?
    current_user
        .memberships
        .where(organization: current_org, user: current_user, role: 'owner')
        .count
        .positive?
  end
end
