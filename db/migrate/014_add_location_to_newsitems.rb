class AddLocationToNewsitems < ActiveRecord::Migration
  def self.up
    add_column :newsitems, :location, :string
  end

  def self.down
    remove_column :newsitems, :location
  end
end
