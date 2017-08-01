# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'bundler'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'erubis' # ONLY until Haml supports rails 5.1 natively
gem 'font-awesome-sass', '~> 4.7.0'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'pg', '~> 0.18'
gem 'postmark-rails', '~> 0.15.0'
gem 'puma', '~> 3.7'
gem 'react-rails'
gem 'react-autocomplete-rails'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-unique-jobs'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'capybara', '~> 2.13.0'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 1.0.0', require: false
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end
