# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.options[:concurrency] = ENV.fetch('SIDEKIQ_CONCURRENCY', 5)

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{config.options[:concurrency]}"
    ActiveRecord::Base.establish_connection
    # Note that as of Rails 4.1 the `establish_connection` method requires
    # the database_url be passed in as an argument. Like this:
    # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end

  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_scheduler.yml', __FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end
