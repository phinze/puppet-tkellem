class tkellem {
  include tkellem::prereqs
  include tkellem::package
  include tkellem::service

  Class['tkellem::prereqs'] ->
    Class['tkellem::package'] ->
    Class['tkellem::service']
}
