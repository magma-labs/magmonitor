# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  layout 'public'

  def index
    redirect_to org_sites_path(current_user.find_organization) if user_signed_in?
  end
end
