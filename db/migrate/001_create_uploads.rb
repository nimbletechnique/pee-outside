class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.column :name, :string
      t.column :data, :binary, :limit=>5.megabytes
      t.column :content_type, :string
      t.column :created, :timestamp
    end
  end

  def self.down
    drop_table :uploads
  end
end
