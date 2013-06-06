

 class patch::setup {


############## Setting up the App ############## 

  file { 'assets_dims.js.sample':
    path => "/Users/${luser}/code/kickass/web/app/assets/javascripts/patch/modules/config/assets_dims.js.sample",
    ensure => present,
    source => "/Users/${luser}/code/kickass/web/app/assets/javascripts/patch/modules/config/assets_dims.js",
    require => Exec['kickass'],
  }


  file { 'web: application.conf.sample':
    path => "/Users/${luser}/code/kickass/web/conf/application.conf.sample",
    ensure => present,
    source => "/Users/${luser}/code/kickass/web/conf/application.conf",
    require => Exec['kickass'],
  }

  file { 'api: application.conf.sample':
    path => "/Users/${luser}/code/kickass/api/conf/application.conf.sample",
    ensure => present,
    source => "/Users/${luser}/code/kickass/api/conf/application.conf",
    require => Exec['kickass'],
  }



# Adding the appropriate hosts (local patch communities) to your /etc/hosts file



  exec { 'newline':
    command => "echo \$\"\\n# chriswashere\" >> /etc/hosts",
    user => root,
  } ->
  exec { 'subdomains':
    command => "/usr/local/bin/psql -U patchy -A -tc \"SELECT subdomain FROM communities;\" | column -t | sed -e 's/^/127.0.0.1 /' -e 's/\$/.patch.local/' >> /etc/hosts",
    user => root,
  }


}