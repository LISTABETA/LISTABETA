class ChangeAllApprovedStartupsToPublished < ActiveRecord::Migration
  class Startup < ActiveRecord::Base;end

  def self.up
    Startup.where(status: Status::APPROVED).each do |startup|
      startup.update_attributes(status: Status::PUBLISHED, published_at: DateTime.now)
    end
  end

  def self.down
    Startup.where(status: Status::PUBLISHED).each do |startup|
      startup.update_attributes(status: Status::APPROVED, published_at: nil)
    end
  end
end
