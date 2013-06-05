
  
 class patch::setup {


  include postgresapp
  include postgresql
  include sysctl          # for postgresql  

  ############## PSQL stuff ############## 

  class patch::setup::stop_nginx inherits nginx {
    Service['dev.nginx'] { ensure  => stopped }
  }   

  class patch::setup::stop_psql inherits postgresql {
    Service['dev.postgresql'] { ensure  => stopped }
  }

  include patch::setup::stop_nginx
  include patch::setup::stop_psql

  exec { 'patchy db':
    command => "createdb -U patchy patchy -h localhost",
    requires => [ Class['patch::setup::stop_nginx'], 
                  Class['include patch::setup::stop_psql'] ],
  } ->
  exec { 'patchy_test db':
    command => "createdb -U patchy patchy_test -h localhost",
  } ->
  exec { 'patchy_api db':
    command => "createdb -U patchy patchy_api -h localhost",
  }

}