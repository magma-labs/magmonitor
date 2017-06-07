# frozen_string_literal: true

class Site < ApplicationRecord
  belongs_to :organization
  has_many :site_checks
  has_many :site_check_results, through: :site_checks
  has_and_belongs_to_many :check_locations, join_table: :sites_check_locations

  include Sluggable

  def last_site_check_results
    site_check_results.order('created_at desc').limit(10)
  end
end
