
class patch::app {
	
############## For Rails migrations ############## 

  exec { 'bundl install':
    cwd => "/Users/${luser}/code/kickass/migrations/",
    command => "bundle install",
    user => root,
  } ->
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
  } ->
  exec { 'redis':
    command => "brew install redis",
    timeout => 0,
  } ->
  exec { 'autostart redis':
    command => "ln -sfv /opt/boxen/homebrew/Cellar/redis/*/*.plist ~/Library/LaunchAgents",
  } ->
  exec { 'manually start redis':
  	command => "launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist",
  }
}