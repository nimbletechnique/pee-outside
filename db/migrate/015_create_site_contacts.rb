class CreateSiteContacts < ActiveRecord::Migration
  def self.up
    create_table :site_contacts do |t|
      t.column :category, :string
      t.column :message, :text
      t.column :email, :string
      t.column :created, :timestamp
    end
  end

  def self.down
    drop_table :site_contacts
  end
end
