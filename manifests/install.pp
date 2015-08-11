#
# Install logstash-forwarder
# Make sure that you copy your cert to files/logstash-forwarder.crt
#

class logstash_forwarder::install {
  apt::source {'elasticsearch':
    comment  => 'Elasticsearch repo',
    location => 'http://packages.elasticsearch.org/logstashforwarder/debian',
    release  => stable,
    repos    => 'main',
    key      => {
      'id'     => 'D27D666CD88E42B4',
      'source' => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    },
    include  => {
      'src' => false,
    },
  }

  package { 'logstash-forwarder':
    ensure  => present,
    require => Apt::Source['elasticsearch'],
  }

  file {['/etc/pki','/etc/pki/tls','/etc/pki/tls/certs']:
    ensure => directory,
  }

  file {'/etc/pki/tls/certs/logstash-forwarder.crt':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/logstash_forwarder/logstash-forwarder.crt',
    require => File['/etc/pki/tls/certs'],
  }

  service {'logstash-forwarder':
    ensure  => 'running',
    enable  => true,
    require => Package['logstash-forwarder'],
  }

  file {'/etc/logstash-forwarder.conf':
    ensure  => 'present',
    content => template('logstash_forwarder/logstash-forwarder.conf.erb'),
    require => Package['logstash-forwarder'],
  }
}
