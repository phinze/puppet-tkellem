define tkellem::network(
  $networkname = $title,
  $host,
  $port = 6697,
  $ssl = true,
  $public = false
){
  $protocol = $ssl ? {
    false => 'irc',
    true  => 'ircs'
  }
  $address = "${protocol}://${host}:${port}/"

  $public_opt = $public ? {
    false => '',
    true  => '--public'
  }

  $tkellem_db = '/var/lib/tkellem/.tkellem/tkellem.sqlite3'
  $network_exists_sql = "'select count(*) from networks where name = \"${networkname}\"'"

  # TODO: interrogate existing config and see if the network needs updating (hosts added/removed, etc)

  exec { "add-tkellem-network-${networkname}":
    user        => 'tkellem',
    environment => 'HOME=/var/lib/tkellem',
    command     => "/usr/local/bin/tkellem admin 'network ${public_opt} --name=${networkname} ${address}'",
    unless      => "/usr/bin/[ $(usr/bin/sqlite3 ${tkellem_db} ${network_exists_sql}) != \"0\" ]"
  }

}
