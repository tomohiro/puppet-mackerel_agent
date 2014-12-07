# == Class: mackerel_agent::service
#
class mackerel_agent::service(
  $ensure = running,
  $enable = true,
) {
  service { 'mackerel-agent':
    ensure => $ensure,
    enable => $enable
  }
}
