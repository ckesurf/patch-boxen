
  
 class patch::setup {

#  include sublime_text_2
#  sublime_text_2::package { 'Emmet':
#      source => 'sergeche/emmet-sublime'
#  }



  file { '.ivy2':
    path => "/Users/${boxen_user}/.ivy2",
    ensure => directory,
  }

  file { '.credentials':
    path => "/Users/${boxen_user}/.ivy2/.credentials",
    ensure => present,
    require => File['.ivy2'],
    content => "realm=Sonatype Nexus Repository Manager
host=patch-nexus-a01.ihost.aol.com
user=deploy
password=P4tch-deploy!",
  }


}