class AddNameAndLocationToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :name, :string
    add_column :comments, :location, :string
  end

  def self.down
    remove_column :comments, :name
    remove_column :comments, :location
  end
end
