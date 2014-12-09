# == Class: mackerel_agent::config
#
class mackerel_agent::config(
  $ensure  = present,
  $apikey  = undef,
) {
  file { 'mackerel-agent.conf':
    ensure  => $ensure,
    path    => '/etc/mackerel-agent/mackerel-agent.conf',
    content => template('mackerel_agent/mackerel-agent.conf.erb')
  }
}
