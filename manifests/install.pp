class cyrus::install {

  include cyrus::variables
  
  user { 'cyrus':
    groups => ['ssl-cert'],
    uid    => 311
  }

  package { [$cyrus::variables::cyrus_pkg]:
    ensure  => present,
    require => User ['cyrus']
  }
}

