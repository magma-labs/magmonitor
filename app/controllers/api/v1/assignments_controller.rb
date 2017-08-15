# frozen_string_literal: true

module Api
  module V1
    class AssignmentsController < BaseController
      def create
        result = Magmonitor::AssignmentsService.new(params).perform_assign_user
        if result
          render json: result, serializer: AssignmentSerializer
        else
          render json: { success: false }, status: 500
        end
      end
    end
  end
end
