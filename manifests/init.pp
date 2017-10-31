# main 

class zcashpuppet (
  $rpcpassword  = $::zcashpuppet::params::rpcpassword

) inherits zcashpuppet::params {
  contain zcashpuppet::install
}
