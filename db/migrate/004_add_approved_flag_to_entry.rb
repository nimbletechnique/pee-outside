class AddApprovedFlagToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :approved, :boolean, :default=>false
  end

  def self.down
    remove_column :entries, :approved
  end
end
