source 'https://rubygems.org'

gem "rails", "3.2.6"
gem "rails-i18n"
gem "jquery-rails"
gem "libv8", "~> 3.11.8"
gem "less-rails-bootstrap"
gem "kaminari"
gem "devise"
gem "oauth2"
gem "cancan"

group :production do
  gem "pg"
  gem "thin"
  #gem "therubyracer-heroku"
end

group :assets do
  gem "sass-rails", "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :development, :test do
    gem "sqlite3"
    gem "rspec-rails", "~> 2.11.0"
    gem "taps", "~> 0.3.24"
    gem "factory_girl_rails", :require => false
    gem "debugger"
    gem "therubyracer"
end

group :development do
    gem "faker", "~> 1.0.1"
end

group :test do
    gem "capybara"
    gem "database_cleaner"
end
