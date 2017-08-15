# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_user!

      def current_org
        @current_org ||= current_user.find_organization(params[:org_id])
      end

      private

      def page_number
        params.dig(:page, :number) || 1
      end
    end
  end
end
