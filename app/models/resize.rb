require 'rubygems'
require 'RMagick'

# quick hack for dreamhost for an old version of RMagick
class Magick::Image
  def resize_to_fit!(cols, rows)
    change_geometry(Magick::Geometry.new(cols, rows)) do |ncols, nrows|
      resize!(ncols, nrows)
    end
  end

  def resize_to_fit(cols, rows)
    change_geometry(Magick::Geometry.new(cols, rows)) do |ncols, nrows|
      resize(ncols, nrows)
    end
  end
end


class Resize

  # resizes an upload and imprints a watermark
  def self.resize_and_watermark(data, width, height)
    return data if data.empty?
    img = Magick::Image.from_blob(data).first
    img.resize_to_fit!(width, height)
    
    text = "\251 peeoutside.org"
    copyright = Magick::Draw.new
    copyright.annotate(img, 0, 0, 5, 5, text) do
      self.font = 'Helvetica'
      self.pointsize = 15
      self.font_weight = Magick::BoldWeight
      self.fill = 'white'
      self.gravity = Magick::SouthEastGravity
    end
    img.to_blob
  end
  
  
end