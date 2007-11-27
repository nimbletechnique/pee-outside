class AddNewsitemFkToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :newsitem_id, :integer
  end

  def self.down
    remove_column :comments, :newsitem_id
  end
end
