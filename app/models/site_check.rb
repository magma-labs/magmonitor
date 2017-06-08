# frozen_string_literal: true

class SiteCheck < ApplicationRecord
  belongs_to :site
  has_many :site_check_results
  has_and_belongs_to_many :check_locations, join_table: :sites_check_locations

  validates :name, :target_url, :check_type, :check_rate, presence: true

  accepts_nested_attributes_for :check_locations
end
