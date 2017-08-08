# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        users = current_org.users.page(params[:page][:number]).per(30)
        render json: users
      end

      def autocomplete
        users = current_org.users
            .where('name ilike :name OR email ilike :name', name: "%#{params[:keyword]}%")
            .page(page_number).per(10)
        render json: users, each_serializer: Api::V1::MinimalUserSerializer
      end
    end
  end
end
