web: bundle exec puma -t 2:#{RAILS_MAX_THREADS:5} -w ${PUMA_WORKERS:2} -p ${PORT:-3000} -e ${RACK_ENV:-development}
worker_america: CHECK_LOCATION_NAME=America bundle exec sidekiq -C config/sidekiq.rb
