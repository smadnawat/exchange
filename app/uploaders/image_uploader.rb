# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  version :thumb do
    # process :resize_to_fit => [150, 150]
    cloudinary_transformation :width => 100, :height => 100,:crop => :thumb
  end

  version :thumb1 do
    #process :resize_to_fit => [300, 300]
    cloudinary_transformation :width => 300, :height => 300,:crop => :thumb
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  #  def default_url
  #   # "/assets/images" + [version_name, "sample.png"].compact.join('_')
  #   ActionController::Base.helpers.asset_path([thumb, "no_image.jpg"].compact.join('_'))
  # end



  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # attr_reader :width, :height
  # attr_accessor :image_cache
  # before :cache, :capture_size
  
  # def capture_size(file)
  #   if version_name.blank? # Only do this once, to the original version
  #     if file.path.nil? # file sometimes is in memory
  #       img = ::MiniMagick::Image::read(file.file)
  #       @width = img[:width]
  #       @height = img[:height]
  #     else
  #       @width, @height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
  #     end
  #   end
  # end


end
