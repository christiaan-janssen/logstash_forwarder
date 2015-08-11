# == Class: logstash_forwarder
#
#  This module will install and configure Logstash-Forwarder. It will default
# to a logstash server on you local machine (127.0.0.1:5000). It is importand
# that you generate a certificate on you logstash server to work with
# logstash-forwarder. (See Generat SSL Certificate at:
# https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04)
#
#  By default this module will setup logstash-forwarder to forward
#  /var/log/syslog and /var/log/autlog
#
#
# === Variables
#
#   The addres or ip of your logstash server. This has to match your certificate
#   $logstash_server      = '127.0.0.1',
#
#   Logstash server port
#   $logstash_server_port = 5000,
#
#   Logstash server timeout
#   $timeout              = 15,
#
#   An array with paths to logfiles and the type you want to give them
#   $file_paths           = [],
#
#
# === Examples
#
#  class { 'logstash_forwarder':
#        logstash_server      => "192.168.0.1",
#        logstash_server_port => 5001,
#        timeout              => 10,
#        file_paths           => [
#                { path => '/var/log/bla', type =>'logtype1'},
#                { path => '/var/log/bla2', type => 'logtype2'},
#        ],
# }
#
# === Authors
#
# Christiaan Janssen christiaanjanssen@drunkturtle.com
#
# === Copyright
#
# Copyright 2015 Christiaan Janssen, unless otherwise noted.
#
class logstash_forwarder (
  $logstash_server      = '127.0.0.1',
  $logstash_server_port = 5000,
  $timeout              = 15,
  $file_paths           = [],
){
  class{'logstash_forwarder::install':}
}
