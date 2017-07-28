# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :authenticate_user!, :check_user_registration
  before_action :allowed_to_invite?, only: %i[index create]

end
