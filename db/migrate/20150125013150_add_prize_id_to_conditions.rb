class AddPrizeIdToConditions < ActiveRecord::Migration
  def change
    add_column :conditions, :prize_id, :integer
  end
end
