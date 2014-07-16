# -*- encoding: utf-8 -*-
require File.expand_path('../lib/places_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Tom Hulihan']
  gem.email         = %w(hulihan.tom159@gmail.com)
  gem.description   = %q(An API client for Google Places)
  gem.summary       = %q(An API client for Google Places)
  gem.homepage      = 'https://github.com/nahiluhmot/google_places'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^spec\//)
  gem.name          = 'places_api'
  gem.require_paths = %w(lib)
  gem.version       = PlacesAPI::VERSION
  gem.add_dependency 'hashie', '~> 3.2.0'
  gem.add_dependency 'excon', '~> 0.38.0'
  gem.add_dependency 'json', '~> 1.8.1'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end
