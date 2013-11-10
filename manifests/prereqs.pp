class tkellem::prereqs(
  $logdir = "/var/lib/tkellem/.tkellem/logs"
) {
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
    home       => '/var/lib/tkellem',
    managehome => true
  }

  file { '/var/lib/tkellem/.tkellem':
    ensure => directory,
    owner  => 'tkellem',
    group  => 'tkellem'
  }

  # If the logdir is different from the default, we need to
  # create a symlink before the process starts. (Better would
  # be to make tkellem configurable.)
  if $logdir != '/var/lib/tkellem/.tkellem/logs' {
    file { $logdir:
      ensure => directory,
      owner  => 'tkellem',
      group  => 'tkellem',
      mode   => 0755
    }

    file { '/var/lib/tkellem/.tkellem/logs':
      ensure => link,
      target => $logdir
    }
  }
}
