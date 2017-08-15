# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < BaseController
      def current
        render json: current_org
      end
    end
  end
end
