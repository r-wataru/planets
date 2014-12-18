source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.6'
gem 'mysql2'

gem "json", "~> 1.8.1"
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'spring', group: :development
gem 'kaminari', '~> 0.16.1'

gem 'rails-i18n'
gem "omniauth", "~> 1.2.2"
gem 'omniauth-facebook', '~> 2.0.0'
gem 'rmagick', '~> 2.13.3', :require => 'RMagick'
gem 'chart-js-rails'
gem "mail-iso-2022-jp", '~> 2.0.0'

# Database related gems
gem 'foreigner', '~> 1.6.1'
gem 'database_cleaner', '~> 1.2.0'

# Custom Validators
gem 'date_validator', '~> 0.7.0'
gem 'email_validator', '~> 1.4.0'

# Misc.
gem 'bcrypt', '~> 3.1.7'
gem 'nokogiri', '~> 1.6.3'
gem 'factory_girl_rails', '~> 4.4.1'

# Asset related gems
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 4.2.1'
gem 'sass-rails',   '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', :platforms => :ruby
gem 'bootstrap-sass', '~> 3.2.0.2'
gem 'autoprefixer-rails'
gem 'font-awesome-rails'

# 本プロジェクトでは CoffeeScript を利用しないが、Tilt の警告を消すために必要。
gem 'coffee-script', '>= 2.2.0'

group :development do
  gem 'annotate', '~> 2.6.5'
  gem 'thin', '~> 1.5.0'
  gem 'spring', require: false
  gem 'spring-commands-rspec', '~> 1.0.2'
  gem 'quiet_assets', '~> 1.0.3'
  gem 'pry', '~> 0.10.1'
  gem 'pry-rails', '~> 0.3.2'
  gem 'pry-byebug', '~> 2.0.0'
  gem 'capistrano', '~> 3.2.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-maintenance', github: 'capistrano/maintenance', require: false
  gem 'capistrano3-unicorn', '~> 0.2.1', require: false
end

group :test do
  gem 'rspec', '~> 3.1.0'
  gem 'rspec-rails', '~> 3.1.0'
  gem 'rspec-given', '~> 3.5.4'
  gem 'launchy'
  gem 'mocha', require: false
  gem 'rspec-rails-mocha', '~> 0.3.2', require: false
  gem 'bourne', '~> 1.5.0'
  gem 'capybara', '~> 2.4.1'
  gem 'capybara-webkit', '~> 1.3.0'
  gem 'connection_pool', '~> 2.0.0'
  gem "simplecov", "~> 0.9.1", require: false
  gem 'i18n-spec'
end

group :development, :test do
  gem 'timecop', '~> 0.7.1'
end

group :staging, :production do
  gem 'unicorn', '~> 4.8.3'
end