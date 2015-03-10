class RenameConditionFieldInConditions < ActiveRecord::Migration
  def change
    rename_column :conditions, :condition, :criteria
  end
end
