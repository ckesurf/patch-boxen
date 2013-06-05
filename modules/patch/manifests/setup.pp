
  
 class patch::setup {




  ############## PostGres ############## 
  include postgresapp
  include postgresql
  include sysctl    # for postgresql  

  exec {'pg db':
    command => "initdb /usr/local/var/postgres -E utf8",
    require => Class['postgresql'],
  }

  exec {'pg host':
    command => "sed -i.bak 's:host    all             all             127.0.0.1/32            trust:host    all             all             127.0.0.1/32            md5:' /usr/local/var/postgres/pg_hba.conf",
    require => Exec['pg db'],
  }
}