class RemovePhaseFromStartups < ActiveRecord::Migration
  def change
    remove_column :startups, :phase, :string
  end
end
