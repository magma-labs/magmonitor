# frozen_string_literal: true

require 'net/http'

# Object responsible to perform real checks against sites, used when the site check is
# type http, it checks ssl, availability and response time
# :reek:InstanceVariableAssumption { enabled: false }
class SiteCheckHttpWorker
  include Sidekiq::Worker

  # TODO: make queue name to be dynamic so pro version can have more priority
  sidekiq_options queue: 'high', unique: :until_and_while_executing, retry: false

  attr_reader :site_check

  def perform(site_check_id)
    @site_check = SiteCheck.find(site_check_id)

    res, time = perform_check(site_check.target_url)
    site_check.site_check_results.create(payload(res, time.real))
  rescue => exception
    handle_error(exception)
  end

  private

  # :reek:FeatureEnvy { enabled: false }
  def payload(result, response_time)
    {
        raw_response: result.to_json,
        response_code: result.try(:code),
        http_response: result.class,
        response_time: (response_time * 1000).round(0),
        check_location_id: location.id
    }
  end

  def location
    @site_check.check_locations.find_by(name: ENV.fetch('CHECK_LOCATION_NAME', 'America'))
  end

  def handle_error(exception)
    site_check.site_check_results.create(raw_response: exception.to_json,
                                         response_code: 598,
                                         http_response: exception.class,
                                         check_location_id: location.id)
  end

  def perform_check(target_url, follow_redirection_limit = 10)
    raise ArgumentError, 'too many HTTP redirects' if follow_redirection_limit.zero?

    uri = URI(target_url)
    res = nil
    time = Benchmark.measure do
      res = perform_net_call(uri)
      if res.class <= Net::HTTPRedirection
        res, time = perform_check(res['location'], follow_redirection_limit - 1)
      end
    end
    [res, time]
  end

  def request(uri)
    req = Net::HTTP::Get.new(uri, 'User-Agent' => site_check.user_agent)
    req.basic_auth(*site_check.basic_auth.split(':')) if site_check.basic_auth.present?
    req
  end

  def perform_net_call(uri)
    Magmonitor::NetUtilities.http_client(uri).request(request(uri))
  rescue Net::HTTPBadResponse, OpenSSL::SSL::SSLError => exception
    exception
  end
end
