class DropTableQuestionnaires < ActiveRecord::Migration
  def change
    drop_table :questionnaires
  end
end
