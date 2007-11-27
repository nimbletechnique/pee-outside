class AddThumbnails < ActiveRecord::Migration
  def self.up
    add_column :entries, :thumb_small_id, :integer, :null => true
    add_column :entries, :thumb_medium_id, :integer, :null => true
  end

  def self.down
    remove_column :entries, :thumb_small_id
    remove_column :entries, :thumb_medium_id
  end
end
