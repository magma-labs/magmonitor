# frozen_string_literal: true

module Magmonitor
  class SiteStatsService
    attr_reader :site

    delegate :site_check_results, to: :site, prefix: false

    def initialize(site)
      @site = site
    end

    def uptime_since(since = 24.hours.ago)
      scope = site_check_results.since(since)
      total = scope.except_redirects.count
      if total > 0
        good_ones = scope.success.count
        with_errors = scope.with_errors.count
        (100 * (good_ones - with_errors) / total).round(3)
      else
        'N/A'
      end
    end

    def average_load_time(since = 24.hours.ago)
      Site.joins(:site_check_results).where(id: site.id)
          .where('site_check_results.created_at > ?', since)
          .select('sites.id, avg(site_check_results.response_time) response_time')
          .group('sites.id').first.response_time.round(0)
    end

    def by_site_check(since = 24.hours.ago)
      site.site_checks
          .joins(:site_check_results)
          .select('site_checks.id, site_checks.name, avg(site_check_results.response_time) response_time')
      .select('((100 * ( case when response_code < 299 then 1 when response_code > 400 then -1 end) )/ count(1)) uptime')
      .where('site_check_results.created_at > ?', since)
      .group('site_checks.id')
    end
  end
end
