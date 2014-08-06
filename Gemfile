source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Rake, make for ruby!
gem 'rake'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use unicorn as the app server
gem 'unicorn-rails'

# Search google places
gem 'places_api', path: 'gems/places_api'

group :development do
  # Annotate databse models
  gem 'annotate'

  # Interact with the cloud
  gem 'fog'
end

group :development, :test do
  # Test framework
  gem 'rspec-rails'

  # A better IRB with interactive debugging
  gem 'pry-rails'
end
