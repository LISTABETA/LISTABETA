source 'https://rubygems.org'
# Ruby Version
ruby '2.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7'
gem 'rails-i18n'
# Server
gem 'passenger', '~> 5.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
gem 'pg_search', '~> 1.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use slim templates
gem 'slim-rails', '~> 3.1'
# Twitter bootstrap
gem 'bootstrap-sass', '~> 3.3'
# Simple form for form wrappers
gem 'simple_form', '~> 3.3'
# ActiveAdmin for admin management
gem 'activeadmin', github: 'activeadmin'
# To manage users
gem 'devise', '~> 4.2'
gem 'devise-i18n', '~> 1.1'
# Enumerate_it
gem 'enumerate_it', '~> 1.3'
# For avatar uploading
gem 'carrierwave', '~> 0.11'
gem 'fog', '~> 1.38'
gem 'mini_magick', '~> 4.4'
# Google Analytics
gem 'google-analytics-rails', '~> 1.1'
# See https://github.com/sstephenson/execjs#readme for more supported runtime
# gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilde
# gem 'jbuilder', '~> 1.2'
# To work with tags, like markets field onside Startup Model
gem 'acts-as-taggable-on', '~> 3.5.0'
# To work with friendly-id on Startups show page
gem 'friendly_id', '~> 5.1.0'
# For group records by all kind of dates
gem 'groupdate', '~> 2.4.0'
# Charts API
gem 'chartkick', '~> 1.3.2'
# For elegant meta_tags
gem 'meta-tags', '~> 2.3', require: 'meta_tags'
# For pagination
gem 'kaminari', '~> 0.17'
# Requests to Getup Cloud
gem 'httparty', '~> 0.13.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'thin'
end

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry-rails', '~> 0.3.4'
  gem 'letter_opener'
  gem 'quiet_assets'
end

group :test do
  gem 'rspec-rails', '~> 3.5.2'
  gem 'machinist', '~> 2.0'
  gem 'database_cleaner', '~> 1.5'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', '~> 0.12', require: false
  gem 'webmock', '~> 2.1'
end
