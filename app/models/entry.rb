class Entry < ActiveRecord::Base
  belongs_to :upload,
    :class_name => 'Upload',
    :foreign_key => 'upload_id'
  
  belongs_to :small_thumbnail,
    :class_name => 'Upload',
    :foreign_key => 'thumb_small_id'

  belongs_to :medium_thumbnail,
    :class_name => 'Upload',
    :foreign_key => 'thumb_medium_id'
    
  has_many :comments
  
  validates_presence_of :title

  def before_create
    self.created = Time.now
  end

end
