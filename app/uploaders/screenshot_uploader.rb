# encoding: utf-8

class ScreenshotUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # For Rails 4
  include Sprockets::Rails::Helper

  # Used for validation
  attr_reader :width, :height

  # Dimensions validation
  before :cache, :capture_size

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/user/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path("/#{[version_name, "startup_default.png"].compact.join('_')}")
  end

  # Process files as they are uploaded:
  # process resize_to_fill: [910, 500]
  #
  # def scale(width, height)
  #   # do something
  # end

  # fetching dimensions in uploader, validating it in model
  def capture_size(file)
    if version_name.blank? # Only do this once, to the original version
      if file.path.nil? # file sometimes is in memory
        img = ::MiniMagick::Image::read(file.file)
        @width = img[:width]
        @height = img[:height]
      else
        @width, @height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
      end
    end
  end

  # Create different versions of your uploaded files:
  version :full do
    process resize_to_fill: [1080, 810]
  end

  version :thumb do
    process resize_to_fill: [323, 242]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
