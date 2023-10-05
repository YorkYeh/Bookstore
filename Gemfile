# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'faker'
end

group :development do
  gem 'rubocop', '~> 1.56'
  gem 'web-console'
  gem "annotate", "~> 3.2"  
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem "devise", "~> 4.9"
gem "aasm", "~> 5.5"
gem "braintree", "~> 4.14"
