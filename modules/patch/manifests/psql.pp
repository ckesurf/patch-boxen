


class patch::psql {

  ############## PSQL stuff ############## 

  exec { 'psql':
    command => "brew install postgres",
    timeout => 0,
  } ->
  exec {'pg db':
    command => "initdb /usr/local/var/postgres -E utf8",
    user => superuser,
  } ->
  exec {'pg host':
    command => "sed -i.bak 's:host    all             all             127.0.0.1/32            trust:host    all             all             127.0.0.1/32            md5:' /usr/local/var/postgres/pg_hba.conf",
  } ->
  exec {'psql conf1':
    command => "sed -i.bak 's:max_connections = 20:max_connections = 50:' /usr/local/var/postgres/postgresql.conf",
  } ->
  exec {'psql conf2':
    command => "sed -i.bak 's:shared_buffers = 1600kB:shared_buffers = 500kB:' /usr/local/var/postgres/postgresql.conf",
  } ->
  exec { 'superuser':
   command => "psql -h localhost postgres -c \"create role patchy with createdb login password 'patchy'; ALTER ROLE patchy WITH SUPERUSER;\"",
  } ->
  exec {'autostart psql server':
    command => 'ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents',
  } ->
  exec {'manually start psql server':
    command => 'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist',
  } ->
  exec { 'patchy db':
    command => "createdb -U patchy patchy -h localhost",
  } ->
  exec { 'patchy_test db':
    command => "createdb -U patchy patchy_test -h localhost",
  } ->
  exec { 'patchy_api db':
    command => "createdb -U patchy patchy_api -h localhost",
  } ->
  exec { 'postgis':
    command => "brew install postgis",
    timeout => 0,
  } ->
  exec { 'patchy postgis':
    command => "psql -d patchy -f /usr/local/share/postgis/postgis.sql -h localhost",
  } ->
  exec { 'patchy spatial':
    command => "psql -d patchy -f /usr/local/share/postgis/spatial_ref_sys.sql -h localhost",
  } ->
  exec { 'patchy_test postgis':
    command => "psql -d patchy_test -f /usr/local/share/postgis/postgis.sql -h localhost",
  } ->
  exec { 'patchy_test spatial':
    command => "psql -d patchy_test -f /usr/local/share/postgis/spatial_ref_sys.sql -h localhost",
  } ->
  exec { 'patchy_api postgis':
    command => "psql -d patchy_api -f /usr/local/share/postgis/postgis.sql -h localhost",
  } ->
  exec { 'patchy_api spatial':
    command => "psql -d patchy_api -f /usr/local/share/postgis/spatial_ref_sys.sql -h localhost",
  }




}