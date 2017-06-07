# frozen_string_literal: true

class SitesController < ApplicationController
  def index
    @sites = current_org.sites
  end

  def show
    @site = current_org.sites.find_by(slug: params[:id])
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

  private

  def site_params
    params.require(:site).permit(:name)
  end
end
