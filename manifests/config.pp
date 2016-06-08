# == Class: mackerel_agent::config
#
class mackerel_agent::config(
  $ensure          = present,
  $apikey          = undef,
  $roles           = undef,
  $host_status     = undef,
  $metrics_plugins = {},
  $check_plugins   = {}
) {
  file { '/etc/mackerel-agent/conf.d':
    ensure  => directory,
    require => Package['mackerel-agent']
  }

  file { 'mackerel-agent.conf':
    ensure  => $ensure,
    path    => '/etc/mackerel-agent/mackerel-agent.conf',
    content => template('mackerel_agent/mackerel-agent.conf.erb'),
    notify  => Class['mackerel_agent::service']
  }
}
