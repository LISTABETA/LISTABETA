class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @recently = Startup.order_by_publication.limit(8)
    @past     = Startup.order_by_publication.limit(40) - @recently
    @all_markets = Startup.approved.tag_counts_on(:markets).order(:name).limit(20)
  end

  def markets
    if params[:tag]
      @startups = Startup.published.tagged_with(params[:tag].gsub('-',' '), on: :markets)
    else
      @markets = Startup.published.tag_counts_on(:markets).order(:name)
    end
  end

  def dashboard
    @startups = current_user.startups.pending +
                current_user.startups.approved +
                current_user.startups.published

    set_meta_tags noindex: true, nofollow: true
  end
end
