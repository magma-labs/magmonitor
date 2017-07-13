web: puma -C config/puma.rb
worker_america: RAILS_MAX_THREADS=5 CHECK_LOCATION_NAME=America bundle exec sidekiq -C config/sidekiq.yml
