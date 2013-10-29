class tkellem::service {
  file { '/etc/init/tkellem.conf':
    ensure => present,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/tkellem/init/tkellem.conf'
  }

  service { 'tkellem':
    ensure     => 'running',
    provider   => 'upstart',
    hasrestart => true,
    hasstatus  => true,
    require    => File['/etc/init/tkellem.conf']
  }
}
