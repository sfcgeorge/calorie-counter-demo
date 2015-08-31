source "https://rubygems.org"

gem "rails", "4.2.3"

gem "rails-api"
gem "active_model_serializers", github: "rails-api/active_model_serializers"

gem "bcrypt", "~> 3.1.7"
gem "has_secure_token"
gem "warden"

gem "sqlite3"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "named_seeds"
end

group :test do
  gem "shoulda-matchers", require: false
  gem "factory_girl_rails"
  gem "forgery"
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'
