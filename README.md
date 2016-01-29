Puppet module for mackerel-agent
================================================================================

[![Puppet Forge](https://img.shields.io/puppetforge/v/tomohiro/mackerel_agent.svg?style=flat-square)](https://forge.puppetlabs.com/tomohiro/mackerel_agent)
[![Dependency Status](https://img.shields.io/gemnasium/Tomohiro/puppet-mackerel_agent.svg?style=flat-square)](https://gemnasium.com/Tomohiro/puppet-mackerel_agent)
[![Build Status](https://img.shields.io/travis/Tomohiro/puppet-mackerel_agent.svg?style=flat-square)](https://travis-ci.org/Tomohiro/puppet-mackerel_agent)


Table of Contents
--------------------------------------------------------------------------------

1. [Overview - What is the mackerel_agent module?](#overview)
2. [Setup - The basics of getting started](#setup)
3. [Usage - How to use the module](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)


Overview
--------------------------------------------------------------------------------

This Puppet module install and configure [mackerel-agent](https://github.com/mackerelio/mackerel-agent).


Setup
--------------------------------------------------------------------------------

Install via Puppet Forge:

```sh
$ puppet module install tomohiro-mackerel_agent
```


Usage
--------------------------------------------------------------------------------

```puppet
class { 'mackerel_agent':
  apikey              => 'Your API Key',
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
```

### Hiera

```yaml
mackerel_agent::apikey: 'Your API Key'
mackerel_agent::use_metrics_plugins: true
mackerel_agent::use_check_plugins: true
mackerel_agent::metrics_plugins:
  apache2: '/usr/local/bin/mackerel-plugin-apache2'
  php-opcache: '/usr/local/bin/mackerel-plugin-php-opcache'
mackerel_agent::check_plugins:
  access_log: '/usr/local/bin/check-log --file /var/log/access.log --pattern FATAL'
  check_cron: '/usr/local/bin/check-procs -p crond'
```


Limitations
--------------------------------------------------------------------------------

These operation systems are supported.

- RHEL 6
- CentOS 6
- Debian 7
- Ubuntu 14.04

The person who want to add an operating system to supported list should implement it himself.


Development
--------------------------------------------------------------------------------

### Requirements

- Puppet 3.7 or later
- librarian-puppet


### Setup development environments

Install dependencies:

```sh
$ bundle install --path vendor/bundle
$ bundle exec librarian-puppet install
```

You can run smoke tests:

```sh
$ echo 'your api key' > .mackerel-api-key # Put a your mackerel API key
$ vagrant up
$ vagrant provision
```


### Testing

Unit tests:

```sh
$ bundle exec rake spec
```

Acceptance tests:

```sh
$ export DOCKER_HOST=tcp://your-docker-host-ip:port
$ bundle exec rake beaker
```


### Contributing

See [CONTRIBUTING](CONTRIBUTING.md) guideline.


LICENSE
--------------------------------------------------------------------------------

&copy; 2014 - 2015 Tomohiro TAIRA.

This project is licensed under the Apache License, Version 2.0.
See [LICENSE](LICENSE) for details.
