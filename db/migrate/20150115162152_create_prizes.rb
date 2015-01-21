class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :description
      t.integer :existences

      t.timestamps
    end
  end
end
