# == Class: zcashpuppet::install
#
# Installs packages
#
# == Actions:
#
# * TODOTODOTODO
# 
# 
#
# === Authors:
#
# Marius Sveum Olsen <marsols@stud.ntnu.no>
# Sondre Ahlgren <sondrah@stud.ntnu.no>
#
# === Copyright:
#
# No copyright yet

#
#
class zcashpuppet::install (
  $rpcpassword = $::zcashpuppet::rpcpassword
#  $config_directory     = $::zcashpuppet::config_directory,

) {


  apt::key {'MasterKey':
    id     => 'F1E214037E94E950BA8577B263C4A2169C1B2FA2',
    server => 'apt.z.cash',
    source => 'https://apt.z.cash/zcash.asc'
  }

  package { 'apt-transport-https':
    ensure   => 'installed',
    notify   => File['/etc/apt/sources.list.d/zcash.list'],
  }

  file { '/etc/apt/sources.list.d/zcash.list':
    ensure  => 'present',
    content => 'deb [arch=amd64] https://apt.z.cash/ jessie main',
    notify  => Package['zcash']
  }
  
  package { 'zcash':
    ensure   => 'installed',
    notify   => File['/root/.zcash/']
  }

  file { '/root/.zcash/':
    ensure => 'directory',
    notify => File['/root/.zcash/zcash.conf/']
  }

  file { '/root/.zcash/zcash.conf/':
    ensure  => 'present',
    content => template('zcashpuppet/config.erb'),
    #notify  => Class['password'],
    replace => false,
  }
}

#class password {
#  if $rpcpassword =~ /(.{40,})/ {
#    file_line { 'test': #ONLYIF rpcpassword finnes i hiera
#      path   => '/root/.zcash/zcash.conf',
#      line   => "rpcpassword=$rpcpassword",
#      #notify => Exec['zcashpuppet_gen_password'],
#      #onlyif => "test `echo -n $rpcpassword | wc -c` -gt 0",
#    }
#  }
#  else {
#    exec { 'zcashpuppet_gen_password':
#      command  => 'echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >> /root/.zcash/zcash.conf',
#      path     => '/usr/bin:/usr/sbin:/bin',
#      provider => shell,
#      onlyif   => "test `wc -l /root/.zcash/zcash.conf | cut -d' ' -f1` -eq 4",
#    }
#  }
#}
