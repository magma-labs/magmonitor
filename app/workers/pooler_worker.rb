# frozen_string_literal: true

# :reek:UtilityFunction { enabled: false }
class PoolerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'high', retry: false

  # In theory, we will execute multiple instances of sidekiq across multiple data centers
  # Each datacenter will have its own redis server but will share same database
  # When we start sidekiq, we'll define what location name the data center belongs to
  def perform(*_args)
    check_location = CheckLocation.find_by name: ENV.fetch('CHECK_LOCATION_NAME')
    SiteCheckQuery.new(check_location.id).sites_to_check.each do |site_check|
      SiteCheckHttpWorker.perform_async site_check.id
    end
  end
end
