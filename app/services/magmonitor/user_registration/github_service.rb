# frozen_string_literal: true

module Magmonitor
  module UserRegistration
    class GithubService < Base
      def user_name
        @params[:info][:nickname]
      end
    end
  end
end
