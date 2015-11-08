# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
class { 'mackerel_agent':
  apikey              => $apikey,
  use_metrics_plugins => true,
  use_check_plugins   => true,
  metrics_plugins     => {
    apache2     => '/usr/local/bin/mackerel-plugin-apache2',
    php-opcache => '/usr/local/bin/mackerel-plugin-php-opcache'
  },
  check_plugins       => {
    access_log => '/usr/local/bin/check-log --file /var/log/access.log --pattern FATAL',
    check_cron => '/usr/local/bin/check-procs -p crond'
  }
}
