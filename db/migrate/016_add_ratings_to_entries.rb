class AddRatingsToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :rating, :float, :default=>0.0
    add_column :entries, :number_ratings, :integer, :default=>0
  end

  def self.down
    remove_column :entries, :rating
    remove_column :entries, :number_ratings
  end
end
