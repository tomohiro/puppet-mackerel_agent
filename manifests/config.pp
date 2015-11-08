# == Class: mackerel_agent::config
#
class mackerel_agent::config(
  $ensure          = present,
  $apikey          = undef,
  $metrics_plugins = {},
  $check_plugins   = {}
) {
  file { 'mackerel-agent.conf':
    ensure  => $ensure,
    path    => '/etc/mackerel-agent/mackerel-agent.conf',
    content => template('mackerel_agent/mackerel-agent.conf.erb'),
    notify  => Class['mackerel_agent::service']
  }
}
