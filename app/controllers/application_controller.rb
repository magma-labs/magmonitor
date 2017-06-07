# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :user_signed_in?, :check_user_registration

  helper_method :current_user, :logged_in?, :current_org

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def user_signed_in?
    redirect_to '/' unless logged_in?
  end

  def check_user_registration
    redirect_to new_registration_flow_path if logged_in? && !current_user.fully_registered?
  end

  def current_org
    @current_org ||= current_user.find_organization(params[:org_id])
  end
end
