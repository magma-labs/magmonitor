# frozen_string_literal: true

module Magmonitor
  module UserRegistration
    class GoogleOauth2Service < Base
      def user_name
        params[:info][:name]
      end
    end
  end
end
