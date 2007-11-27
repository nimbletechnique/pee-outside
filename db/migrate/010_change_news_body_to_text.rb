class ChangeNewsBodyToText < ActiveRecord::Migration
  def self.up
    change_column :newsitems, :body, :text
  end

  def self.down
    change_column :newsitems, :body, :string
  end
end
