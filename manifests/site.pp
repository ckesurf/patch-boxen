require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => true,
  user        => $luser,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    "${boxen::config::home}/homebrew/Cellar",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::luser}"
  ]
}

File {
  group => 'staff',
  owner => $luser
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => Class['git']
}

Service {
  provider => ghlaunchd,
}

Homebrew::Formula <| |> -> Package <| |>


node default {
  # core modules, needed for most things
#  include dnsmasq
  include git
  include hub
#  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }


  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }


  stage { 'install': require => Stage['main'] }
  stage { 'psql': require => Stage['install'] }
  stage { 'setup': require => Stage['psql'] }
 # stage { 'app': require => Stage['setup'] }
  stage { 'redis': require => Stage['setup'] }

# When the app stage is ready, change redis's required stage to app
# so it all flows in the right order. But it doesn't REALLY matter,
# they can both really on setup.

# I am commenting out the app stage for now since it breaks too much.
# also, it seems like using Boxen with rails is still in its early stages


################## Ruby crap... ##################

# this works
# include ruby::1_9_3

# so does this! We'll use this instead for now
# Set the global default ruby (auto-installs it if it can)
class { 'ruby::global':
  version => '1.9.3'
}
# Note: I would specify version => 1.9.3-p429, but this breaks it.
# apparently p429 was implemented very recently, so I'm not messing with that.
# also the most recent puppet-ruby seems to break, won't go into detail now.



################## Patch stages ##################



  class {'patch::install':
    stage => 'install'
  }

  class {'patch::psql':
    stage => 'psql'
  }

  class {'patch::setup':
    stage => 'setup'
  }

#   when the time is right...
#  class {'patch::app':
#    stage => 'app'
#  }

  class {'patch::redis':
    stage => 'redis'
  }


}



