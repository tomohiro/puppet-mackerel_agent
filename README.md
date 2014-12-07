Puppet module for mackerel-agent
================================================================================

This Puppet module provides to install and configure [mackerel-agent](https://github.com/mackerelio/mackerel-agent).


Usage
--------------------------------------------------------------------------------

```puppet
class { 'mackerel_agent':
  apikey => 'Your API Key'
}
```


Limitations
--------------------------------------------------------------------------------

Currently supporting Red Hat based operating systems.


LICENSE
--------------------------------------------------------------------------------

&copy; 2014 Tomohiro TAIRA.
This project is licensed under the Apache License, Version 2.0.
See LICENSE for details.
