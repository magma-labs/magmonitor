# frozen_string_literal: true

module Magmonitor
  # Custom NetUtilities used by Magmonitor to check sites
  # built to handle with ssl negotiations, check certificates
  # or skip ssl validations
  class NetUtilities
    class << self
      # Creates an http client intelligently, depending on whether check ssl or not
      #
      # @params uri [URI] object with parsed url
      # @returns [NET::HTTP] object ready to perform actions
      def http_client(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.is_a?(URI::HTTPS)
          http.use_ssl = true
          # http.verify_mode = OpenSSL::SSL::VERIFY_NONE if options[:skip_ssl_validation]
        end
        http
      end
    end
  end
end
