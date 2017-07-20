# frozen_string_literal: true

class SiteCheckResult < ApplicationRecord
  belongs_to :site_check
  belongs_to :check_location

  delegate :name, to: :check_location, prefix: true

  scope :success, -> { where('response_code between 200 and 299') }
  scope :redirects, -> { where('response_code between 300 and 399') }
  scope :client_errors, -> { where('response_code between 400 and 499') }
  scope :server_errors, -> { where('response_code between 500 and 599') }
  scope :with_errors, -> { where('response_code between 400 and 599') }
  scope :except_redirects, -> { where.not('response_code between 300 and 399') }

  scope :since, ->(time) { where('site_check_results.created_at >= ?', time) }

  delegate :name, to: :check_location, prefix: true
end
