source 'https://rubygems.org'

gem 'puppet', ENV['PUPPET_VERSION'] || '>= 3.7'
gem 'facter', '>= 1.7.0'

group :test, :development do
  # Unit tests
  gem 'puppetlabs_spec_helper', '>= 0.1.0'
  gem 'puppet-lint', '>= 0.3.2'
  gem 'librarian-puppet', '~> 2.2.0'
  gem 'metadata-json-lint', '~> 0.0.6'

  # Acceptance tests
  gem 'beaker'
  gem 'beaker-rspec'
end
