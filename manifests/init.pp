class tkellem(
  $default_listen = true
){
  include tkellem::prereqs
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
