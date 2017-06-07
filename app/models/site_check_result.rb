# frozen_string_literal: true

class SiteCheckResult < ApplicationRecord
  belongs_to :site_check
  belongs_to :check_location
end
