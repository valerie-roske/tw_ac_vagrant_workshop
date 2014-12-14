file {'/etc/motd' : 
  content => 'hello party people'
}

exec { 'apt-update':
    command => "/usr/bin/apt-get update",
      onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'"
}

Exec["apt-update"] -> Package <| |>

rbenv::install { "vagrant":
  group => 'vagrant',
  home  => '/home/vagrant'
}

rbenv::compile { "2.1.1":
  user => "vagrant",
  home => "/home/vagrant",
}

include '::mysql::server'
