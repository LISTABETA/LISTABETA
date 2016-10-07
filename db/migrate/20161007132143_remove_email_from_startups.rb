class RemoveEmailFromStartups < ActiveRecord::Migration
  def change
    remove_column :startups, :email, :string
  end
end
