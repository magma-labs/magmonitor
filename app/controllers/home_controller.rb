# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :user_signed_in?

  layout 'public'

  def index
    redirect_to org_sites_path(current_user.find_organization) if logged_in?
  end
end
