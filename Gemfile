source 'https://rubygems.org'

gem 'bundler', '>= 1.8.4'

# Declare your gem's dependencies in jasperserver-rails.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem 'jquery-rails'

gem 'protected_attributes'

group :development, :test do
  gem 'bigdecimal', '1.3.5' # Rails 4
  # gem 'thin'
end

group :test do
  gem 'sqlite3', '~> 1.3.9'
  gem 'vcr', '~> 4.0'
  gem 'webmock', '~> 3.4'
end
