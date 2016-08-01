# == Class: mackerel_agent
#
# This class install and configure mackerel-agent
#
# === Parameters
#
# [*ensure*]
#   Passed to the mackerel_agent
#   Defaults to present
#
# [*apikey*]
#   Your mackerel API key
#   Defaults to undefined
#
# [*roles*]
#   Name of roles to which the server is assigned
#   Defaults to undefined
#
# [*host_status*]
#   Set the host's status
#   Defaults to undefined
#
# [*filesystems*]
#   Set the ignore filesystems 
#   Defaults to undefined
#
# [*service_ensure*]
#   Whether you want to mackerel-agent daemon to start up
#   Defaults to running
#
# [*service_enable*]
#   Whether you want to mackerel-agent daemon to start up at boot
#   Defaults to true
#
# [*use_metrics_plugins*]
#   Whether you want to use official metrics plugins
#   Defaults to undefined
#
# [*use_check_plugins*]
#   Whether you want to use official check plugins
#   Defaults to undefined
#
# [*metrics_plugins*]
#   Metics plugin parameters
#   Defualts to empty hash
#
# [*check_plugins*]
#   Check plugin parameters
#   Defualts to empty hash
#
# === Examples
#
#  class { 'mackerel_agent':
#    apikey              => 'Your API Key',
#    roles               => ['service:web', 'service:database'],
#    host_status         => {
#      on_start => 'working',
#      on_stop  => 'poweroff'
#    },
#    filesystems         => 'ignore = "/dev/ram.*"'
#    use_metrics_plugins => true,
#    use_check_plugins   => true,
#    metrics_plugins     => {
#      apache2           => '/usr/local/bin/mackerel-plugin-apache2',
#      php-opcache       => '/usr/local/bin/mackerel-plugin-php-opcache'
#    },
#    check_plugins       => {
#      access_log => '/usr/local/bin/check-log --file /var/log/access.log --pattern FATAL',
#      check_cron => '/usr/local/bin/check-procs -p crond'
#    }
#  }
#
# === Authors
#
# Tomohiro TAIRA <tomohiro.t@gmail.com>
#
# === Copyright
#
# Copyright 2014 - 2015 Tomohiro TAIRA
#
class mackerel_agent(
  $ensure              = present,
  $apikey              = undef,
  $roles               = undef,
  $host_status         = undef,
  $filesystems         = undef,
  $service_ensure      = running,
  $service_enable      = true,
  $use_metrics_plugins = undef,
  $use_check_plugins   = undef,
  $metrics_plugins     = {},
  $check_plugins       = {},
) {
  validate_re($::osfamily, '^(RedHat|Debian)$', 'This module only works on RedHat or Debian based systems.')
  validate_string($apikey)
  validate_bool($service_enable)
  validate_hash($metrics_plugins)
  validate_hash($check_plugins)

  if $roles != undef {
    validate_array($roles)
  }

  if $host_status != undef {
    validate_hash($host_status)
  }

  if $filesystems != undef {
    validate_string($filesystems)
  }

  if $apikey == undef {
    crit('apikey must be specified in the class paramerter.')
  } else {
    class { 'mackerel_agent::install':
      ensure              => $ensure,
      use_metrics_plugins => $use_metrics_plugins,
      use_check_plugins   => $use_check_plugins
    }

    class { 'mackerel_agent::config':
      apikey          => $apikey,
      roles           => $roles,
      host_status     => $host_status,
      filesystems     => $filesystems,
      metrics_plugins => $metrics_plugins,
      check_plugins   => $check_plugins,
      require         => Class['mackerel_agent::install']
    }

    class { 'mackerel_agent::service':
      ensure  => $service_ensure,
      enable  => $service_enable,
      require => Class['mackerel_agent::config']
    }
  }
}
