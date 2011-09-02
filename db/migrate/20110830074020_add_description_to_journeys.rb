class AddDescriptionToJourneys < ActiveRecord::Migration
  def self.up
    add_column :journeys, :description, :string
  end

  def self.down
    remove_column :journeys, :description
  end
end
