require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']

# Use librarian-puppet to manage fixtures instead of .fixtures.yml.
# Offers more possibilities like explicit version management, forge downloads...
task :librarian_spec_prep do
  sh 'librarian-puppet install --path=spec/fixtures/modules/'
end

task :spec_prep => :librarian_spec_prep
