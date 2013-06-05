
  
 class patch::setup {


  include postgresapp
  include postgresql
  include sysctl          # for postgresql  

  ############## PSQL stuff ############## 

  # For creating the patchy superuser
  # I am 99% sure this works. 
  exec { 'superuser':
   command => "psql -h localhost postgres -c \"create role patchy with createdb login password 'patchy'; ALTER ROLE patchy WITH SUPERUSER;\"",
   require => Class['postgresql'],
  }

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