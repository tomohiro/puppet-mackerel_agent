require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet_blacksmith/rake_tasks'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']

# Use librarian-puppet to manage fixtures instead of .fixtures.yml.
# Offers more possibilities like explicit version management, forge downloads...
task :librarian_spec_prep do
  sh 'librarian-puppet install --path=spec/fixtures/modules/'
end

task :spec_prep => :librarian_spec_prep

# Customize puppet-blacksmith default configuration.
# https://github.com/voxpupuli/puppet-blacksmith#customizing-tasks
Blacksmith::RakeTask.new do |t|
  t.tag_pattern = '%s'
end
