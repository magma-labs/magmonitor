# frozen_string_literal: true

module Magmonitor
  module UserRegistration
    class Base
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def persist
        User.find_or_create_by(email: user_email) do |user|
          user.name = user_name
          user.image = user_image
          user.password = Devise.friendly_token[0, 20]
        end
      end
    end
  end
end
