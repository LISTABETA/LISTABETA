class DropTableStartupPackSubscribers < ActiveRecord::Migration
  def change
    drop_table :startup_pack_subscribers
  end
end
