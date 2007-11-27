class Upload < ActiveRecord::Base
  
  belongs_to :entry,
    :class_name => 'Entry',
    :foreign_key => 'entry_id'
    
  validates_presence_of :data, :message=>" -- File must be supplied"
  
  def self.copy_from(upload)
    copy = Upload.new
    copy.name = upload.name
    copy.data = String.new(upload.data)
    copy.content_type = upload.content_type
    copy
  end
  
  def before_create
    self.created = Time.now
  end
  
  # sets the uploaded data on this model
  def uploaded_data=(file)
    self.data = []
    if !file.kind_of?(String)
      self.name = file.original_filename
      self.content_type = file.content_type.chomp
      self.data = file.read
    end
  end
end
