# frozen_string_literal: true

module Magmonitor
  module UserRegistration
    class GithubService < Base
      def user_email
        @params[:info][:email]
      end

      def user_image
        @params[:info][:image]
      end

      def user_name
        @params[:info][:nickname]
      end

      def user_provider
        @params[:provider]
      end

      def user_uid
        @params[:uid]
      end
    end
  end
end
