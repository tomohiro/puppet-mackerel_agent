Puppet module for mackerel-agent
================================================================================

Table of Contents
--------------------------------------------------------------------------------

1. [Overview - What is the mackerel_agent module?](#overview)
2. [Usage - The Class available configuration](#usage)
3. [Limitations - OS compatibility](#limitations)
4. [Development - Guide for contributing to the module](#development)


Overview
--------------------------------------------------------------------------------

This Puppet module install and configure [mackerel-agent](https://github.com/mackerelio/mackerel-agent).


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
