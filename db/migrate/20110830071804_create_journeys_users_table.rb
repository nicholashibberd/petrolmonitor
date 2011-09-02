class CreateJourneysUsersTable < ActiveRecord::Migration
  def self.up
    create_table :journeys_users, :id => false do |t|
      t.integer :journey_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :journeys_users
  end
end
