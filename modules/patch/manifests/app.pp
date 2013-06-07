
class patch::app {
	
############## For Rails migrations ############## 

# bundler and bundle install breaks like none other.
# however, seems Puppet installs bundler (earlier version, like 1.2.5 as opposed
# to 1.3.5). Maybe this is whats wrong. Bundle install is also incomplete, not all
# gems are installed for whatever reason.
# This may also relate to the fact that ruby 1.9.3-p429 is not implemented correctly
# on puppet-ruby

  exec { 'bundler':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "gem install bundler",
    user => root,
  } ->
  exec { 'bundle install':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "bundle install",
    user => root,
  } ->
  file { 'database':
    path => "/Users/${luser}/code/kickass/migrations/config/database.yml",
    ensure => present,
    source => "/Users/${luser}/code/kickass/migrations/config/database.yml.sample",
  } ->
  exec { 'migrate':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "rake db:migrate",
  }

}