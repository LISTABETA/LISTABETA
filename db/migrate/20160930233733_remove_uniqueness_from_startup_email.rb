class RemoveUniquenessFromStartupEmail < ActiveRecord::Migration
  def change
    remove_index :startups, :email
  end
end
