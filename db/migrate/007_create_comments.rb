class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :entry_id, :integer
      t.column :data, :string
      t.column :created, :timestamp
    end
  end

  def self.down
    drop_table :comments
  end
end
