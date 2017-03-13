require 'spec_helper'
require 'carrierwave/test/matchers'

describe ScreenshotUploader do
  include CarrierWave::Test::Matchers

  let(:startup) { create(:startup, :approved) }
  let(:uploader) { ScreenshotUploader.new(startup, :screenshot) }

  before do
    ScreenshotUploader.enable_processing = true
    uploader.store!(File.open(Rails.root.join('spec', 'fixtures', 'cover.png')))
  end

  after do
    ScreenshotUploader.enable_processing = false
    uploader.remove!
  end

  describe 'default_url' do
    it 'returns default image in assets path' do
      mock = Startup.new
      expect(mock.screenshot_url).to eq ActionController::Base.helpers.asset_path("startup_default.png")
    end
  end

  describe 'full version' do
    it 'should have a size of 1080x810' do
      expect(uploader.full).to have_dimensions(1080, 810)
    end
  end

  describe 'thumb version' do
    it 'should have a size of 323x242' do
      expect(uploader.thumb).to have_dimensions(323, 242)
    end
  end
end
