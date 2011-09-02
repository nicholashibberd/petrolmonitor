class AddMileageToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :mileage, :integer
  end

  def self.down
    remove_column :payments, :mileage
  end
end
