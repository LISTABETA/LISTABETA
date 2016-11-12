class Startup < ActiveRecord::Base;end

class RecreateVersionsOfStartupsScreenshot < ActiveRecord::Migration
  def change
    Startup.find_each do |startup|
      startup.screenshot.recreate_versions! if startup.screenshot.present?
    end
  end
end
