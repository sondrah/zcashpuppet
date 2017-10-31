# main 

class zcashpuppet (
  $rpcpassword  = $::zcashpuppet::params::rpcpassword

) inherits zcashpuppet::params {
  contain zcashpuppet::install
  contain zcashpuppet::password
  Class['::zcashpuppet::install'] -> Class['::zcashpuppet::password']
}
