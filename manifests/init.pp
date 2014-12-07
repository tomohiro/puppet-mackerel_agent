# == Class: mackerel_agent
#
# This class installs and configures mackerel-agent
#
# === Parameters
#
# TODO
#
# === Examples
#
#  class { 'mackerel_agent':
#    apikey => 'Your API Key'
#  }
#
# === Authors
#
# Tomohiro TAIRA <tomohiro.t@gmail.com>
#
# === Copyright
#
# Copyright 2014 Tomohiro TAIRA
#
class mackerel_agent(
  $ensure         = present,
  $apikey         = undef,
  $pidfile        = './pid',
  $root           = '.',
  $verbose        = false,
  $service_ensure = 'running',
  $service_enable = true
) {
  validate_re($::osfamily, '^(RedHat)$', 'This module only works on Red Hat based systems.')
  validate_string($apikey)
  validate_bool($service_enable)

  if $apikey == undef {
    crit('apikey must be specified in the class paramerter.')
  } else {
    class { 'mackerel_agent::install':
      ensure => $ensure
    }

    class { 'mackerel_agent::config':
      apikey  => $apikey,
      pidfile => $pidfile,
      root    => $root,
      verbose => $verbose,
      require => Class['mackerel_agent::install'],
      notify  => Class['mackerel_agent::service']
    }

    class { 'mackerel_agent::service':
      ensure  => $service_ensure,
      enable  => $service_enable,
      require => Class['mackerel_agent::config']
    }
  }
}
