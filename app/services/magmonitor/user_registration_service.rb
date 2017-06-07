# frozen_string_literal: true

module Magmonitor
  class UserRegistrationService
    attr_reader :attrs

    def initialize(attrs)
      @attrs = attrs
    end

    # We just find by email, it is our unique identifier
    def perform
      User.find_or_create_by(email: user_info(:email)) do |user|
        user.name = user_info(:name)
        user.image = user_info(:image)
      end
    end

    private

    def user_info(attribute)
      @attrs[:info][attribute]
    end
  end
end
