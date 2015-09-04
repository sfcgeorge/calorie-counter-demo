source "https://rubygems.org"

gem "rails", "4.2.3"

gem "rails-api"
gem "active_model_serializers", github: "rails-api/active_model_serializers"

gem "bcrypt", "~> 3.1.7"
gem "has_secure_token"
gem "warden"
gem "pundit"

gem "sqlite3"

gem "sass-rails"
gem "uglifier"
gem "coffee-rails"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "rspec-rails", "~> 3.0"
  gem "named_seeds"
  gem "database_cleaner"
end

group :test do
  gem "shoulda-matchers", require: false
  gem "json_expressions"
  gem "factory_girl_rails"
  gem "forgery"
end

source "https://rails-assets.org" do
  gem "rails-assets-angular"
  gem "rails-assets-angular-resource"
  gem "rails-assets-angular-route"
  gem "rails-assets-angular-utf8-base64"
  gem "rails-assets-bootstrap"
end
