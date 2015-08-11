#
# Install logstash-forwarder
# Make sure that you copy your cert to files/logstash-forwarder.crt
#

class logstash_forwarder::install {
  apt::source {'elasticsearch':
    comment     => 'Elasticsearch repo',
    location    => 'http://packages.elasticsearch.org/logstashforwarder/debian',
    release     => stable,
    repos       => 'main',
    key         => 'D27D666CD88E42B4',
    key_source  => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    include_src => false,
  }

  package { 'logstash_forwarder':
    ensure  => present,
    require => apt::source['elasticsearch'],
  }

  file {'/etc/pki/tls/certs':
    ensure => directory,

  }

  file {'/etc/pki/tls/certs/logstash-forwarder.crt':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/logstash_forwarder/logstash-forwarder.crt',
    require => file['/etc/pki/tls/certs'],
  }

  service {'logstash-forwarder':
    ensure  => 'running',
    enabled => true,
    require => package['logstash_forwarder'],
  }

  file {'/etc/logstash-forwarder.conf':
    ensure   => 'present',
    contents => template('logstash-forwarder.conf.erb'),
    require  => package['logstash_forwarder'],
  }
}
