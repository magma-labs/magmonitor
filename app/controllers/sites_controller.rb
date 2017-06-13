# frozen_string_literal: true

class SitesController < ApplicationController
  def index
    @sites = current_org.sites
  end

  def show
    @site = find_site
  end

  def new
    @site = Site.new
  end

  def create
    @site = current_org.sites.create(site_params)
    if @site.valid?
      redirect_to org_sites_path(current_org)
    else
      flash[:danger] = @site.errors.full_messages.join(', ')
      redirect_to new_org_site_path(current_org)
    end
  end

  def edit
    @site = find_site
  end

  def update
    @site = find_site
    if params[:site].key?(:site_check) && params[:site][:site_check][:name].present?
      @site.site_checks.create(site_check_params)
    end
    if @site.update(site_params)
      flash[:success] = 'Updated successfully'
    else
      flash[:danger] = 'There was an error trying to update the site'
    end
    redirect_to edit_org_site_path(current_org, @site)
  end

  private

  def site_params
    params.require(:site).permit(:name, site_checks_attributes: site_check_attributes)
  end

  def site_check_params
    params[:site][:site_check][:check_location_ids].delete('0')
    params[:site].require(:site_check).permit(site_check_attributes)
  end

  def site_check_attributes
    [
        :id, :name, :target_url, :basic_auth,
        :check_type, :user_agent, :check_rate, check_location_ids: []
    ]
  end

  def find_site
    current_org.sites.find_by(slug: params[:id])
  end
end
