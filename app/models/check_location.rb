# frozen_string_literal: true

class CheckLocation < ApplicationRecord
  has_and_belongs_to_many :site_checks, join_table: :sites_check_locations

  scope :active, -> {}

end
