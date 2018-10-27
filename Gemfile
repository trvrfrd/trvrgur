source 'https://rubygems.org'
ruby '2.4.5'

gem 'rails', '~> 5.2.1'
gem 'pg', '~> 0.11'
gem 'activerecord-postgresql-adapter'
gem 'rabl'
gem 'backbone-on-rails'
gem 'ejs'
gem 'jquery-rails'
gem 'bcrypt-ruby'
gem 'figaro'
gem 'paperclip'
gem 'aws-sdk-s3'
gem 'bootsnap'
gem 'puma'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'listen'
end

group :test do
  gem 'capybara'
  # this feels risky but fixes a really obnoxious deprecation warning from Capybara
  gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master'
  gem 'webmock'
  gem 'rails-controller-testing'
end
