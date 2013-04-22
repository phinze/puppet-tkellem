define tkellem::user(
  $password,
  $username = $title,
  $admin    = false
){
  $role = $admin ? {
    true => 'admin',
    false => 'user'
  }

  exec { "add-tkellem-user-${username}":
    user        => 'tkellem',
    environment => 'HOME=/home/tkellem',
    command     => "/usr/local/bin/tkellem admin 'user ${username} --role=${role}'",
    unless      => "/usr/local/bin/tkellem admin 'user' | /bin/grep '${username}'",
    require     => Class['tkellem']
  }

  $tkellem_db = '/home/tkellem/.tkellem/tkellem.sqlite3'
  $select_password_sql = "'select password from users where username = \"${username}\"'"
  $password_sha = "$(echo -n '${password}' | shasum | awk '{print \$1}')"

  exec { "set-tkellem-password-${username}":
    user        => 'tkellem',
    environment => 'HOME=/home/tkellem',
    command     => "/usr/local/bin/tkellem admin 'password --user=${username} ${password}'",
    unless      => "/usr/bin/sqlite3 ${tkellem_db} ${select_password_sql} | /bin/grep ${password_sha}",
    require     => Exec[ "add-tkellem-user-${username}"]
  }
}
