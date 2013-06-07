

class patch::install  {

  ############## Text Editor, Chrome, and Java ############## 

  include sublime_text_2
  sublime_text_2::package { 'Emmet':
      source => 'sergeche/emmet-sublime'
  }
  
  include chrome
  include java


  ############## For Kickass ############## 


  file { 'code':
    path => "/Users/${luser}/code",
    ensure => directory,
  } ->
  exec {'kickass':
    cwd => "/Users/${luser}/code",
    command => "git clone git@github.com:patch-engineering/kickass.git",
    timeout => 0,
  } -> 
  exec {'submodule':
    cwd => "/Users/${luser}/code/kickass",
    command => "git submodule update --init",
    require => Exec['kickass'],
  }

  ############## Credentials ############## 

  file { '.ivy2':
    path => "/Users/${luser}/.ivy2",
    ensure => directory,
  } ->
  file { '.credentials':
    path => "/Users/${luser}/.ivy2/.credentials",
    ensure => present,
    content => "realm=Sonatype Nexus Repository Manager
host=patch-nexus-a01.ihost.aol.com
user=deploy
password=P4tch-deploy!",
  }


}