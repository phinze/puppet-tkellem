class tkellem(
  $default_listen = true,
  $logdir         = '/var/lib/tkellem/.tkellem/logs'
){
  class { 'tkellem::prereqs':
    logdir => $logdir
  }
  include tkellem::package
  include tkellem::service

  if ($default_listen) {
    tkellem::listen { 'default': }
    Class['tkellem::service'] -> Tkellem::Listen['default']
  }

  Class['tkellem::prereqs'] ->
    Class['tkellem::package'] ->
    Class['tkellem::service']
}
