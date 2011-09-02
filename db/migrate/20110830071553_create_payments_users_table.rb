class CreatePaymentsUsersTable < ActiveRecord::Migration
  def self.up
    create_table :payments_users, :id => false do |t|
      t.integer :payment_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :payments_users
  end
end
