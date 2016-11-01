class ChangeAllApprovedStartupsToPublished < ActiveRecord::Migration
  class Startup < ActiveRecord::Base;end

  def self.up
    Startup.where(status: Status::APPROVED).each do |startup|
      startup.update_attributes(status: Status::PUBLISHED)
    end
  end

  def self.down
    Startup.where(status: Status::PUBLISHED).each do |startup|
      startup.update_attributes(status: Status::APPROVED)
    end
  end
end
