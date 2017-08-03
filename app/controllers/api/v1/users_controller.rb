# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        users = User.all
        render json: users
      end
    end
  end
end
