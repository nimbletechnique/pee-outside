class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.column :title, :string
      t.column :created, :timestamp
      t.column :upload_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :entries
  end
end
