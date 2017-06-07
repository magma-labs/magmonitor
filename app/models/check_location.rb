# frozen_string_literal: true

class CheckLocation < ApplicationRecord
  has_and_belongs_to_many :check_locations, join_table: :sites_check_locations
end
