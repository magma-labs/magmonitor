# frozen_string_literal: true

Sidekiq.configure_server do |config|
  if ENV['SIDEKIQ_CONCURRENCY'].to_i.positive?
    config.options[:concurrency] = ENV['SIDEKIQ_CONCURRENCY'].to_i
  end

  ActiveRecord::Base.configurations[Rails.env][:pool] = config.options[:concurrency]
  ActiveRecord::Base.establish_connection

  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_scheduler.yml', __FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end
