class CreateNewsitems < ActiveRecord::Migration
  def self.up
    create_table :newsitems do |t|
      t.column :title, :string
      t.column :body, :string, :length=>65000
      t.column :created, :timestamp
    end
  end

  def self.down
    drop_table :newsitems
  end
end
