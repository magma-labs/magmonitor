# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        users = current_org.users
        render json: users
      end

      def autocomplete
        users = current_org.users
            .where('name ilike :name OR email ilike :name', name: "%#{params[:keyword]}%")
            .page(page_number).per(10)
        render json: users, each_serializer: Api::V1::MinimalUserSerializer
      end

      def assign_to_group
        result = Magmonitor::GroupsManagerService.new(params).perform_assign_user
        if result
          render json: { success: true }, status: 200
        else
          render json: { success: false }, status: 500
        end
      end
    end
  end
end
