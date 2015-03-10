class RenameTypeFieldInCondition < ActiveRecord::Migration
  def change
    rename_column :conditions, :type, :cond_type
  end
end
