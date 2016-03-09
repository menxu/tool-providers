class SitesController < ApplicationController
  def index
    @kind_sites = Site.all.group_by(&:kind)
  end
end
