# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

group :production do
  gem 'rails', '~> 7.0.1'

  gem 'bootsnap', require: false
  gem 'importmap-rails'
  gem 'jbuilder'
  gem 'pg'
  gem 'puma', '~> 5.0'
  gem 'rubocop', require: false
  gem 'sprockets-rails'
  gem 'stimulus-rails'
  gem 'tailwindcss-rails'
  gem 'turbo-rails'
end

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
