source 'https://rubygems.org'
ruby '2.2.9'

gem 'rails', '~> 3.2.22'
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
gem 'aws-sdk'
gem 'newrelic_rpm'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  # prevent rails console from blowing up?
  gem 'test-unit', '~> 3.0'

  gem 'quiet_assets'
  # gem 'better_errors'
  # gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.1'
end

group :test do
  gem 'capybara'
end
