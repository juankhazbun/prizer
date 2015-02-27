class AddDateWonFieldToWinners < ActiveRecord::Migration
  def change
    add_column :winners, :date_won, :datetime
  end
end
