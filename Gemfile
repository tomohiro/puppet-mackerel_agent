source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion
gem 'facter', '>= 1.7.0'

group :test, :development do
  gem 'puppetlabs_spec_helper', '>= 0.1.0'
  gem 'puppet-lint', '>= 0.3.2'
  gem 'librarian-puppet', '~> 2.2.0'
  gem 'metadata-json-lint', '~> 0.0.6'
end
