define tkellem::listen(
  $port         = 8765,
  $ssl          = true,
  $bind_address = '0.0.0.0'
){
  $protocol = $ssl ? {
    false => 'irc',
    true  => 'ircs'
  }
  $address = "${protocol}://${bind_address}:${port}"

  exec { "add-tkellem-listen-${title}":
    user        => 'tkellem',
    environment => 'HOME=/var/lib/tkellem',
    command     => "/usr/local/bin/tkellem admin 'listen ${address}'",
    unless      => "/usr/local/bin/tkellem admin 'listen' | /bin/grep '${address}'",
    require     => Class['tkellem::service']
  }
}
