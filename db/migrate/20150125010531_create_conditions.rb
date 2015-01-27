class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      
      t.string :type
      t.string :condition
      t.string :offset  
          
      t.timestamps
    end
  end
end
