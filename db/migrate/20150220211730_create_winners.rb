class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :subscriber_id
      t.integer :prize_id
    end
  end
end
