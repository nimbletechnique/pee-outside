class Comment < ActiveRecord::Base

  belongs_to :entry
  belongs_to :newsitem
  validates_presence_of :data

  def before_create
    self.created = Time.now
  end
  
  def before_validation
    # trim the string
    self.data = self.data.strip if self.data
    self.name = self.name.strip if self.name
    self.location = self.location.strip if self.location
  end
  
  def self.find_for_entry(entry)
    Comment.find(:all, :conditions=>"entry_id = #{entry.id}", :order=>"created DESC")
  end
  
  def self.find_for_newsitem(newsitem)
    Comment.find(:all, :conditions=>"newsitem_id = #{newsitem.id}", :order=>"created DESC")
  end
  
end
