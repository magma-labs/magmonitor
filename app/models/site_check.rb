# frozen_string_literal: true

class SiteCheck < ApplicationRecord
  belongs_to :site
  has_many :site_check_results

  def target
    URI::HTTP.build(host: host_name, port: port)
  end
end
