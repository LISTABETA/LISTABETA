class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @all_markets    = Startup.approved.tag_counts_on(:markets).order(:name).limit(20)
    @highlighteds   = Startup.highlighteds.order_by_highlighted_at
    @unhighlighteds = Startup.approved.order_by_approvement.limit(6)
  end

  def markets
    if params[:tag]
      @startups = Startup.approved.tagged_with(params[:tag].gsub('-',' '), on: :markets)
    else
      @markets = Startup.approved.tag_counts_on(:markets).order(:name)
    end
  end

  def dashboard
    @startups = current_user.startups
    set_meta_tags noindex: true, nofollow: true
  end
end
