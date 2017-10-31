class zcashpuppet::password (
  $rpcpassword = $::zcashpuppet::rpcpassword
) {
  if $rpcpassword =~ /(.{40,})/ {
    file_line { 'test': #ONLYIF rpcpassword finnes i hiera
      path   => '/root/.zcash/zcash.conf',
      line   => "rpcpassword=$rpcpassword",
      #notify => Exec['zcashpuppet_gen_password'],
      #onlyif => "test `echo -n $rpcpassword | wc -c` -gt 0",
    }
  }
  else {
    exec { 'zcashpuppet_gen_password':
      command  => 'echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >> /root/.zcash/zcash.conf',
      path     => '/usr/bin:/usr/sbin:/bin',
      provider => shell,
      onlyif   => "test `wc -l /root/.zcash/zcash.conf | cut -d' ' -f1` -eq 4",
    }
  }
}
