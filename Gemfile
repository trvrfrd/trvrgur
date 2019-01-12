source 'https://rubygems.org'
ruby '2.4.5'

gem 'rails', '~> 5.2.1'

gem 'activerecord-postgresql-adapter'
gem 'aws-sdk-s3'
gem 'bcrypt-ruby'
gem 'bootsnap'
gem 'ejs'
gem 'figaro'
gem 'jquery-rails'
gem 'paperclip'
gem 'pg', '~> 0.11'
gem 'puma'
gem 'rabl'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'listen'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  # this feels risky but fixes a really obnoxious deprecation warning from Capybara
  gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master'
  gem 'rails-controller-testing'
  gem 'webmock'
end
