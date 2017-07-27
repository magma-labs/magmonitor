# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_user_registration

  helper_method :check_user_registration,
                :current_org

  private

  def check_user_registration
    redirect_to new_registration_flow_path if user_signed_in? && !current_user.fully_registered?
  end

  def current_org
    @current_org ||= current_user.find_organization(params[:org_id])
  end

  def org_owned_by_current_user?
    current_user.owner_of?(current_org)
  end
end
