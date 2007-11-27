class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :email, :string
      t.column :pledged, :boolean
      t.column :created, :timestamp
    end
  end

  def self.down
    drop_table :signups
  end
end
