
  
 class patch::setup {


  include postgresapp
  include postgresql
  include sysctl          # for postgresql  

  ############## PSQL stuff ############## 


  exec { 'patchy db':
    command => "createdb -U patchy patchy -h localhost",
    require => Class['postgresql']
  }

  exec { 'patchy_test db':
    command => "createdb -U patchy patchy_test -h localhost",
    require => Class['postgresql']

  }

  exec { 'patchy_api db':
    command => "createdb -U patchy patchy_api -h localhost",
    require => Class['postgresql']
  }



}