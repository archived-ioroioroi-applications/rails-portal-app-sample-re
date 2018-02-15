# require 'rmagick'

module Processing
  class Image
    def self.get_image(uri, h, w)    # using RMagick
      h = 100 if h == nil
      w = 100 if w == nil
      rm_img = Magick::ImageList.new(uri)
      if rm_img.columns >= h && rm_img.rows >= w
        return rm_img
      else
        return nil
      end
    end
  end
end
