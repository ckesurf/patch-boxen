

 class patch::setup {
  #Service['dev.postgresql'] { ensure => stopped }

 # exec {'kill psql server':
  #  command => 'pg_ctl -D /usr/local/var/postgres stop -s -m fast',
 # }
  exec {'autostart psql server':
    command => 'ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents',
  } ->
  exec {'manually start psql server':
    command => 'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist',
  } ->
  exec { 'patchy db':
    command => "createdb -U patchy patchy -h localhost",
  }
}