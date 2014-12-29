source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets; Front-end assets
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sprockets-rails', '~> 2.2.2'
gem 'autoprefixer-rails'


# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# JavaScript assets
gem 'jquery-rails'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

#Auth & Authorization
gem 'devise', '~> 3.4.1'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'twitter'

gem 'friendly_id', '~> 5.0.4'

group :staging  do
  gem 'unicorn'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.1'
  gem 'pry'
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'selenium-webdriver'
  gem "capybara-webkit"
  gem 'vcr', '~> 2.9.3'
end

group :development do
  gem 'annotate', github: 'ctran/annotate_models'
  gem 'railroady'
  gem 'terminal-notifier-guard'
  gem 'guard-rspec', require: false
  gem 'fuubar'
end

group :test do
  gem 'database_cleaner'
  gem 'webmock'
  gem 'capybara'
  gem 'cucumber-rails',  require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

