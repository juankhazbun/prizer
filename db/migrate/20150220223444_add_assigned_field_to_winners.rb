class AddAssignedFieldToWinners < ActiveRecord::Migration
  def change
    add_column :winners, :assigned, :boolean
  end
end
