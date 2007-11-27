class AddBasicIndexes < ActiveRecord::Migration
  def self.up
    add_index :comments, :newsitem_id
    add_index :entries, :created
    add_index :faqs, :created
    add_index :newsitems, :created
    add_index :rating_records, :cookie
    add_index :rating_records, :entry_id
  end

  def self.down
    remove_index :comments, :newsitem_id
    remove_index :entries, :created
    remove_index :faqs, :created
    remove_index :newsitems, :created
    remove_index :rating_records, :cookie
    remove_index :rating_records, :entry_id
  end
end
