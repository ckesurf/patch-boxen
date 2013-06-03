
  include sublime_text_2
  sublime_text_2::package { 'Emmet':
      source => 'sergeche/emmet-sublime'
  }



  file { '.ivy2':
    path => "/Users/${id}/.ivy2",
    ensure => directory,
  }

# indentation looks ugly here, not much I can do about it though :/
  file { '.credentials':
    path => "/Users/${id}/.ivy2/.credentials",
    ensure => present,
    require => File['.ivy2'],
    content => "realm=Sonatype Nexus Repository Manager
host=patch-nexus-a01.ihost.aol.com
user=deploy
password=P4tch-deploy!
  }
