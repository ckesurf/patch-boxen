
  
 class patch::setup {


  ############## PostGres ############## 
  include postgresapp

  exec {'pg db':
    command => "initdb /usr/local/var/postgres -E utf8",
    require => Class['postgresapp'],
  }



}