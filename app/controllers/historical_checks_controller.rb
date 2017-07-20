# frozen_string_literal: true

class HistoricalChecksController < ApplicationController
  def index
    @site = find_site
    scope = @site.site_check_results.order('created_at desc')
    @historical_site_checks = scope.page(params[:page].to_i)
  end

  def show
    @site = find_site
    @check = @site.site_check_results.find(params[:id])
  end

  private

  def find_site
    current_org.sites.find_by(slug: params[:site_id])
  end
end
