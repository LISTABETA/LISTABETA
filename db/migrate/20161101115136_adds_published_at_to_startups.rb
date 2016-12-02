class AddsPublishedAtToStartups < ActiveRecord::Migration
  class Startup < ActiveRecord::Base;end

  def self.up
    add_column :startups, :published_at, :datetime
    Startup.where(status: Status::APPROVED).each do |startup|
      startup.update_attributes(published_at: DateTime.now)
    end
  end

  def self.down
    remove_column :startups, :published_at
    Startup.where(status: Status::PUBLISHED).each do |startup|
      startup.update_attributes(published_at: nil)
    end
  end
end
