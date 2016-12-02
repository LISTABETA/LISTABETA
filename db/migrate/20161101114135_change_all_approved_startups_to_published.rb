class ChangeAllApprovedStartupsToPublished < ActiveRecord::Migration
  class Startup < ActiveRecord::Base;end

  def self.up
    Startup.where(status: Status::APPROVED).update_all(status: Status::PUBLISHED)
  end

  def self.down
    Startup.where(status: Status::PUBLISHED).update_all(status: Status::APPROVED)
  end
end
