source 'https://rubygems.org'
ruby '2.3.7'

gem 'rails', '~> 4.2.10'
gem 'pg', '~> 0.11'
gem 'activerecord-postgresql-adapter'
gem 'pry-rails'
gem 'rabl'
gem 'backbone-on-rails'
gem 'ejs'
gem 'jquery-rails'
gem 'bcrypt-ruby'
gem 'figaro'
gem 'paperclip'
gem 'aws-sdk-s3'
gem 'newrelic_rpm'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  # prevent rails console from blowing up?
  gem 'test-unit'

  gem 'quiet_assets'
  # gem 'better_errors'
  # gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  # this feels risky but fixes a really obnoxious deprecation warning from Capybara
  gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master'
  gem 'webmock'
end
