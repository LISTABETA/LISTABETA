class AddDemonstrationToStartups < ActiveRecord::Migration
  def change
    add_column :startups, :demonstration, :string
  end
end
