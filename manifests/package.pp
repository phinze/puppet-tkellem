class tkellem::package {
  package { 'tkellem':
    ensure   => present,
    provider => 'gem',
    require  => [
      Package['build-essential'],
      Package['ruby1.9.3']
    ]
  }
}
