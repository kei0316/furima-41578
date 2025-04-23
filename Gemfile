source "https://rubygems.org"

ruby "3.2.0"

# Rails framework
gem 'rails', '8.0.2'

# The original asset pipeline for Rails
gem "sprockets-rails"

# Database adapter
gem "mysql2", "~> 0.5"

# Use the Puma web server
gem "puma", ">= 5.0"

# ESM import maps
gem "importmap-rails"

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# JSON API builder
gem "jbuilder"

# Timezone data for Windows
gem "tzinfo-data", platforms: %i[windows jruby]

# Faster boot times
gem "bootsnap", require: false

# Active Storage variants
gem "image_processing", "~> 1.2"

# Authentication, image processing, etc.
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
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
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
  gem 'unicorn', '6.1.0'
end

gem 'rack', '3.1.10'