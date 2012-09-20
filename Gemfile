source 'https://rubygems.org'

gem "rails", "3.2.6"
gem "rails-i18n"
gem "jquery-rails"
gem "kaminari"
gem "devise"
gem "cancan"

group :production do
  gem "pg"
  gem "thin"
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
end

group :development do
    gem "faker", "~> 1.0.1"
end

group :test do
    gem "factory_girl", "~> 3.5.0"
    gem "capybara"
    gem "database_cleaner"
end
