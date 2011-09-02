class CreateJourneys < ActiveRecord::Migration
  def self.up
    create_table :journeys do |t|
      t.integer :start_mileage
      t.integer :end_mileage
      t.integer :user_id
      t.integer :group_id
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :journeys
  end
end
