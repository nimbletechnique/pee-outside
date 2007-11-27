class MoveUploadIdToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :upload_id, :integer, :not_null=>true
  end

  def self.down
    remove_column :entries, :upload_id
  end
end
