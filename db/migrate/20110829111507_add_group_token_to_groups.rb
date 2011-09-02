class AddGroupTokenToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :group_token, :string
  end

  def self.down
    remove_column :groups, :group_token
  end
end
