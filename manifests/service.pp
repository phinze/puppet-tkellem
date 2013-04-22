class tkellem::service {
  file { '/etc/init.d/tkellem':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/tkellem/init.d/tkellem'
  }

  exec { 'start-tkellem-at-boot':
    command => '/usr/sbin/update-rc.d tkellem defaults',
    unless  => '/usr/bin/test -s /etc/rc3.d/S20tkellem'
  }

  service { 'tkellem':
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
    require    => File['/etc/init.d/tkellem']
  }
}
