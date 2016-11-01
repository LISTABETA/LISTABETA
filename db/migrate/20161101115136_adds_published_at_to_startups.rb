class AddsPublishedAtToStartups < ActiveRecord::Migration
  def change
    add_column :startups, :published_at, :datetime
  end
end
