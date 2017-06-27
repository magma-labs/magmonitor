# frozen_string_literal: true

class SiteCheckQuery
  attr_reader :location_id

  def initialize(location_id)
    @location_id = location_id
  end

  def sites_to_check(check_rate = 60)
    SiteCheck.joins(:check_locations)
        .where(sites_check_locations: { check_location_id: @location_id })
        .where('(? % check_rate) = 0', Time.now.min * check_rate)
  end
end
