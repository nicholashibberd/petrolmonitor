class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
