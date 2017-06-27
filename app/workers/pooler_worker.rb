# frozen_string_literal: true

class PoolerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'high'

  def perform(*_args)
    CheckLocation.all.each do |check_location|
      redis_connection = proc { Redis.new(url: check_location.redis_url) }
      redis_pool = ConnectionPool.new(size: 1, &redis_connection)
      Sidekiq::Client.via(redis_pool) do
        SiteCheckQuery.new(check_location.id).sites_to_check.each do |site_check|
          SiteCheckHttpWorker.perform_async site_check.id
        end
      end
    end
  end
end
