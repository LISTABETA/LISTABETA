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
# Auto prefixer CSS
gem 'autoprefixer-rails', '~> 6.5'
# Font Awesome
gem 'font-awesome-rails', '~> 4.4.0'
# Simple form for form wrappers
gem 'simple_form', '~> 3.3'
# ActiveAdmin for admin management
gem 'activeadmin', '~> 1.0.0.pre4'
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
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2'
# To work with tags, like markets field onside Startup Model
gem 'acts-as-taggable-on', '~> 3.5.0'
# To work with friendly-id on Startups show page
gem 'friendly_id', '~> 5.1.0'
# Charts API
gem 'chartkick', '~> 1.3.2'
# For elegant meta_tags
gem 'meta-tags', '~> 2.3', require: 'meta_tags'
# For pagination
gem 'kaminari', '~> 0.17'
# Requests to Getup Cloud
gem 'httparty', '~> 0.13.0'
# Use Pundit to manage permissions
gem 'pundit', '~> 1.1'
# To organize and modularize JS files
gem 'initjs'
# Autocomplete for Market's field
gem 'rails-jquery-autocomplete', '~> 1.0.3'

group :development do
  gem 'thin'
end

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry-rails', '~> 0.3.4'
  gem 'letter_opener', '~> 1.4.1'
  gem 'quiet_assets', '~> 1.1.0'
end

group :test do
  gem 'machinist', '~> 2.0'
  gem 'rspec-rails', '~> 3.5.2'
  gem 'database_cleaner', '~> 1.5'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', '~> 0.12', require: false
end
