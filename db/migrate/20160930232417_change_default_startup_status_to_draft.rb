class ChangeDefaultStartupStatusToDraft < ActiveRecord::Migration
  def change
    change_column :startups, :status, :integer, null: false, default: 0
  end
end
