source "https://rubygems.org"

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '8.0.2'

# The original asset pipeline for Rails
gem "sprockets-rails"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

# Use the Puma web server
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire's SPA-like page accelerator
gem "turbo-rails"

# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching
gem "bootsnap", require: false

# Use Active Storage variants
gem "image_processing", "~> 1.2"

gem 'devise'
gem 'mini_magick'
gem 'active_hash'
gem 'pry-rails'
gem 'payjp'
gem 'gon'

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails", "~> 4.0.0"
  gem "factory_bot_rails"
  gem 'faker', '3.5.1'
end

group :development do
  gem "web-console"
  gem "rubocop", "1.71.2", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem "pg"
  gem "unicorn", "6.1.0"
end