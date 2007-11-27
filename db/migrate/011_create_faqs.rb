class CreateFaqs < ActiveRecord::Migration
  def self.up
    create_table :faqs do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :position, :integer
      t.column :created, :timestamp
    end
  end

  def self.down
    drop_table :faqs
  end
end
