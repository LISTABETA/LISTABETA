class PagesController < ApplicationController
  before_action :authenticate_startup!, only:[:dashboard]

  def home
    @all_markets = Startup.where(status: Status::APPROVED).tag_counts_on(:markets).order(:name).limit(20)
    @highlighteds = Startup.highlighteds.order_by_highlighted_at
    @unhighlighteds = Startup.approvateds.order_by_approves.limit(6)
  end

  def markets
    if params[:tag]
      @startups = Startup.where(status: Status::APPROVED).tagged_with(params[:tag].gsub('-',' '), on: :markets)
    else
      @markets = Startup.where(status: Status::APPROVED).tag_counts_on(:markets).order(:name)
    end
  end

  def dashboard
    set_meta_tags noindex: true, nofollow: true
  end
end
