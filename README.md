# logstash_forwarder

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with logstash_forwarder](#setup)
    * [What logstash_forwarder affects](#what-logstash_forwarder-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with logstash_forwarder](#beginning-with-logstash_forwarder)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Install and config logstash-forwarder. By default it will forward /var/log/syslog
and /var/log/autlog. Other logfiles you can add via a array. Tested on Debian 7.8
and Debian 8

## Setup

### What logstash_forwarder affects

This module will add /etc/apt/sources.list.d/elasticsearch.list and install
the logstash-forwarder package and its startup scripts and config file
/etc/logstash-forwarder.conf aswell as its certificate in /etc/pki/tls/certs.

### Setup Requirements

*This module is dependent on puppetlabs-apt, as it will need it to add the repo.*

Before you start you will have to generate a certificate for you logstash server
to comunicate with the logstash-forwarder. Copy this crt file to files/logstash-forwarder.crt
in the module dir. See https://goo.gl/30yTzx for more info.

### Beginning with logstash_forwarder

To start using just add the following to you pp file.
```puppet
include logstash_forwarder
```
## Usage

To change the workign of the module you can do the following

```puppet
class { 'logstash_forwarder':
        logstash_server      => "192.168.0.1",
        logstash_server_port => 5000,
        timeout              => 15,
        file_paths           => [
                { path => '/var/log/logfile1', type =>'logfiletype'},
                { path => '/var/log/logfile2', type => 'logfiletpe2'},
        ],

}
```

file_paths will add seperate entries for ever path, type pair. It will expand to
```
{
    "paths": [ "/var/log/logfile1" ],
    "fields": { "type": "logfiletype" }
},
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This module will only work on Debian based linuxes, as it needs apt to install
logstash-forwarder.

## Development

Feel free to for or add to this module

## Release Notes/Contributors/Etc

11-aug-2015: First release, default install and config
