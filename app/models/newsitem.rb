class Newsitem < ActiveRecord::Base
  
  validates_presence_of :title, :body, :location
  has_many :comments

  def before_create
    self.created = Time.now
  end
  
  def before_validation
    # trim the string
    self.body = self.body.strip
  end
  
end
