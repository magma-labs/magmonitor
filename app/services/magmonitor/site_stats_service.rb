# frozen_string_literal: true

module Magmonitor
  class SiteStatsService
    attr_reader :site

    delegate :site_check_results, to: :site, prefix: false

    def initialize(site)
      @site = site
    end

    # :reek:FeatureEnvy { enabled: false }
    def uptime_since(since = 24.hours.ago)
      scope = site_check_results.since(since)
      total = scope.except_redirects.count
      if total.positive?
        good_ones = scope.success.count
        (100 * good_ones / total).round(3)
      else
        'N/A'
      end
    end

    def average_load_time(since = 24.hours.ago)
      record = Site.joins(:site_check_results).where(id: site.id)
          .where('site_check_results.created_at > ?', since)
          .select('sites.id, avg(site_check_results.response_time) response_time')
          .group('sites.id').first
      record.try(:response_time).to_f.round(0)
    end

    def by_site_check(since = 24.hours.ago)
      uptime = 'sum(case when response_code < 299 then 1 when response_code > 400 then -1 end)'
      site.site_checks
          .joins(site_check_results: :check_location)
          .select('site_checks.id, site_checks.name, check_locations.name location_name')
          .select('avg(site_check_results.response_time) load_time')
          .select("((100 * #{uptime}) / count(1)) uptime")
          .where('site_check_results.created_at > ?', since)
          .group('site_checks.id, check_locations.name')
    end
  end
end
