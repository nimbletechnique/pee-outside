class Faq < ActiveRecord::Base

  validates_presence_of :title, :body
  validates_numericality_of :position
  
  def before_create
    self.created = Time.now
  end


end
