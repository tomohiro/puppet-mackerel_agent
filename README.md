Puppet module for mackerel-agent
================================================================================

[![Puppetforge](https://img.shields.io/puppetforge/v/tomohiro/mackerel_agent.svg?style=flat-square)](https://forge.puppetlabs.com/tomohiro/mackerel_agent)


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

Puppet module:

```sh
$ puppet module install tomohiro-mackerel_agent
```


Usage
--------------------------------------------------------------------------------

```puppet
class { 'mackerel_agent':
  apikey => 'Your API Key'
}
```


Limitations
--------------------------------------------------------------------------------

- RHEL/CentOS 6


Development
--------------------------------------------------------------------------------

### Requirements

- Puppet 3.7
- librarian-puppet


### Contributing

See [CONTRIBUTING](CONTRIBUTING.md) guideline.


### Testing

Install dependencies:

```sh
$ bundle install --path vendor/bundle
$ bundle exec librarian-puppet install
```

Put your mackerel API key:

```sh
$ echo 'your api key' > .mackerel-api-key
```

Run smoke test:

```sh
$ vagrant up
$ vagrant provision
```


LICENSE
--------------------------------------------------------------------------------

&copy; 2014 Tomohiro TAIRA.
This project is licensed under the Apache License, Version 2.0.
See LICENSE for details.
