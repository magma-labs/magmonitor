# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :user_signed_in?
  def index; end
end
