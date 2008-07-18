class EntriesBelongToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :entry_id, :integer, :null => false, :default => 0
    remove_column :entries, :upload_id
  end

  def self.down
    remove_column :uploads, :entry_id
    add_column :entries, :upload_id, :integer, :null => false, :default => 0
  end
end
