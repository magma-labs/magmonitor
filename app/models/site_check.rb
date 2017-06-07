# frozen_string_literal: true

class SiteCheck < ApplicationRecord
  belongs_to :site
  has_many :site_check_results
end
