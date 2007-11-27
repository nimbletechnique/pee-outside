class Signup < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email
  
  def before_create
    self.created = Time.now
  end
end
