class patch::redis {

############## Redis Installation and Setup ############## 

# Note: Do not have adblocker running on your machine
ruby::local { "/Users/${luser}/code/kickass":
  version => '1.9.3-p194'
}
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