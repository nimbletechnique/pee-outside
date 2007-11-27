class CreateRatingRecords < ActiveRecord::Migration
  def self.up
    create_table :rating_records do |t|
      t.column :cookie, :string, :null=>false
      t.column :entry_id, :integer
    end
  end

  def self.down
    drop_table :rating_records
  end
end
