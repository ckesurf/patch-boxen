
class patch::app {
	
############## For Rails migrations ############## 


  exec { 'bundler':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "sudo gem install bundler",
  } ->
  exec { 'bundle install':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "bundle install",
  } ->
  file { 'database':
    path => "/Users/${luser}/code/kickass/migrations/config/database.yml.sample",
    ensure => present,
    source => "/Users/${luser}/code/kickass/migrations/config/database.yml",
  } ->
  exec { 'migrate':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "rake db:migrate",
  } ->
  exec { 'redis':
    command => "brew install redis",
    timeout => 0,
  } ->
  exec { 'autostart redis':
    command => "ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents",
  } ->
  exec { 'manually start redis':
  	command => "launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist",
  }
}