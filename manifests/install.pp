# == Class: mackerel_agent::install
#
class mackerel_agent::install(
  $ensure              = present,
  $use_metrics_plugins = undef,
  $use_check_plugins   = undef,
  $use_mkr             = undef
) {

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Amazon': {
          $baseurl = 'http://yum.mackerel.io/amznlinux/$releasever/$basearch'
          $gpgkey_url = 'https://mackerel.io/assets/files/GPG-KEY-mackerel'
        }
        default: {
          if $::operatingsystemmajrelease == '6' {
            $baseurl = 'http://yum.mackerel.io/centos/$basearch'
            $gpgkey_url = 'https://mackerel.io/assets/files/GPG-KEY-mackerel'
          } else {
            $baseurl = 'http://yum.mackerel.io/v2/$basearch'
            $gpgkey_url = 'https://mackerel.io/file/cert/GPG-KEY-mackerel-v2'
          }
        }
      }

      yumrepo { 'mackerel':
        name     => 'mackerel',
        baseurl  => $baseurl,
        descr    => 'mackerel-agent',
        enabled  => 1,
        gpgkey   => $gpgkey_url,
        gpgcheck => 1,
      }

      $pkg_require = Yumrepo['mackerel']
    }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          if $::operatingsystemmajrelease == '7' {
            $location = 'http://apt.mackerel.io/debian/'
            $id = '2748FD61027D357542F8394DF92F673FC2B48821'
            $gpgkey_url = 'https://mackerel.io/assets/files/GPG-KEY-mackerel'
          } else {
            $location = 'http://apt.mackerel.io/v2/'
            $id = '9DD9479D06BAA71322803AC166332B78417E73EA'
            $gpgkey_url = 'https://mackerel.io/file/cert/GPG-KEY-mackerel-v2'
          }
        }
        'Ubuntu': {
          if $::operatingsystemmajrelease == '14.04' {
            $location = 'http://apt.mackerel.io/debian/'
            $id = '2748FD61027D357542F8394DF92F673FC2B48821'
            $gpgkey_url = 'https://mackerel.io/assets/files/GPG-KEY-mackerel'
          } else {
            $location = 'http://apt.mackerel.io/v2/'
            $id = '9DD9479D06BAA71322803AC166332B78417E73EA'
            $gpgkey_url = 'https://mackerel.io/file/cert/GPG-KEY-mackerel-v2'
          }
        }
        default: {
          # Do nothing
        }
      }

      apt::source { 'mackerel':
        location => $location,
        release  => 'mackerel',
        repos    => 'contrib',
        key      =>  {
          id     => $id,
          source => $gpgkey_url
        },
        include  => {
          source => false
        },
      }

      $pkg_require = Class['apt::update']
    }
    default: {
      # Do nothing
      $pkg_require = undef
    }
  }

  package { 'mackerel-agent':
    ensure  => $ensure,
    require => $pkg_require,
  }

  case $use_metrics_plugins {
    true: {
      package { 'mackerel-agent-plugins':
        ensure  => present,
        require => $pkg_require,
      }
    }
    false: {
      package { 'mackerel-agent-plugins':
        ensure  => absent,
        require => $pkg_require,
      }
    }
    'latest': {
      package { 'mackerel-agent-plugins':
        ensure  => latest,
        require => $pkg_require,
      }
    }
    default: {
      # Do nothing
    }
  }

  case $use_check_plugins {
    true: {
      package { 'mackerel-check-plugins':
        ensure  => present,
        require => $pkg_require,
      }
    }
    false: {
      package { 'mackerel-check-plugins':
        ensure  => absent,
        require => $pkg_require,
      }
    }
    'latest': {
      package { 'mackerel-check-plugins':
        ensure  => latest,
        require => $pkg_require,
      }
    }
    default: {
      # Do nothing
    }
  }

  case $use_mkr {
    true: {
      package { 'mkr':
        ensure  => present,
        require => $pkg_require,
      }
    }
    false: {
      package { 'mkr':
        ensure  => absent,
        require => $pkg_require,
      }
    }
    'latest': {
      package { 'mkr':
        ensure  => latest,
        require => $pkg_require,
      }
    }
    default: {
      # Do nothing
    }
  }
}
