class tkellem::prereqs {
  package { [
    'build-essential',
    'libsqlite3-dev',
    'ruby1.9.3',
    'sqlite3',
  ]:
    ensure => present
  }

  user { 'tkellem':
    ensure     => present,
    managehome => true
  }
}
