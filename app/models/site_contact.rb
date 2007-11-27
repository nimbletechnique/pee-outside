class SiteContact < ActiveRecord::Base
  validates_presence_of :category, :message
  
  def before_create
    self.created = Time.new
  end
end
